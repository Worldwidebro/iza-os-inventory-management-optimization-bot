#!/usr/bin/env python3
"""
IZA OS Inventory Management Optimization Bot
Main application entry point for inventory optimization and intelligence.
"""

import asyncio
import logging
import sys
from pathlib import Path
from typing import Dict, Any

import uvicorn
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

# Add src to path
sys.path.append(str(Path(__file__).parent))

from optimization.inventory_optimizer import InventoryOptimizer
from optimization.cost_optimizer import CostOptimizer
from optimization.demand_optimizer import DemandOptimizer
from algorithms.genetic_algorithm import GeneticAlgorithmOptimizer
from data.collectors.inventory_data_collector import InventoryDataCollector
from api.endpoints.optimization import router as optimization_router
from api.endpoints.algorithms import router as algorithms_router
from api.endpoints.health import router as health_router
from config.optimization_config import OptimizationConfig
from utils.logging_config import setup_logging


# Global instances
inventory_optimizer: InventoryOptimizer = None
cost_optimizer: CostOptimizer = None
demand_optimizer: DemandOptimizer = None
genetic_optimizer: GeneticAlgorithmOptimizer = None
data_collector: InventoryDataCollector = None


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Application lifespan manager for startup and shutdown."""
    global inventory_optimizer, cost_optimizer, demand_optimizer, genetic_optimizer, data_collector
    
    # Startup
    logging.info("🚀 Starting IZA OS Inventory Management Optimization Bot...")
    
    try:
        # Initialize configuration
        config = OptimizationConfig()
        
        # Initialize core components
        data_collector = InventoryDataCollector(config)
        inventory_optimizer = InventoryOptimizer(config, data_collector)
        cost_optimizer = CostOptimizer(config, data_collector)
        demand_optimizer = DemandOptimizer(config, data_collector)
        genetic_optimizer = GeneticAlgorithmOptimizer(config)
        
        # Start data collection
        await data_collector.start()
        
        # Initialize optimization algorithms
        await inventory_optimizer.initialize_algorithms()
        
        logging.info("✅ Inventory Management Optimization Bot initialized successfully")
        
    except Exception as e:
        logging.error(f"❌ Failed to initialize Inventory Optimization Bot: {e}")
        raise
    
    yield
    
    # Shutdown
    logging.info("🛑 Shutting down Inventory Management Optimization Bot...")
    
    if data_collector:
        await data_collector.stop()
    
    logging.info("✅ Inventory Management Optimization Bot shutdown complete")


def create_app() -> FastAPI:
    """Create and configure FastAPI application."""
    
    # Setup logging
    setup_logging()
    
    app = FastAPI(
        title="IZA OS Inventory Management Optimization Bot",
        description="Advanced AI-powered inventory optimization and intelligence bot",
        version="1.0.0",
        lifespan=lifespan
    )
    
    # Add CORS middleware
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    # Include routers
    app.include_router(optimization_router, prefix="/api/v1")
    app.include_router(algorithms_router, prefix="/api/v1")
    app.include_router(health_router, prefix="/api/v1")
    
    # WebSocket connections
    active_connections: Dict[str, WebSocket] = {}
    
    @app.websocket("/ws/optimization")
    async def websocket_optimization(websocket: WebSocket):
        """WebSocket endpoint for real-time optimization updates."""
        await websocket.accept()
        connection_id = f"optimization_{id(websocket)}"
        active_connections[connection_id] = websocket
        
        try:
            while True:
                # Send real-time optimization data
                if inventory_optimizer:
                    optimization_data = await inventory_optimizer.get_realtime_optimization()
                    await websocket.send_json(optimization_data)
                
                await asyncio.sleep(2)  # Update every 2 seconds
                
        except WebSocketDisconnect:
            active_connections.pop(connection_id, None)
            logging.info(f"WebSocket connection {connection_id} disconnected")
    
    @app.websocket("/ws/performance")
    async def websocket_performance(websocket: WebSocket):
        """WebSocket endpoint for real-time performance metrics."""
        await websocket.accept()
        connection_id = f"performance_{id(websocket)}"
        active_connections[connection_id] = websocket
        
        try:
            while True:
                # Send real-time performance data
                if cost_optimizer:
                    performance_data = await cost_optimizer.get_realtime_performance()
                    await websocket.send_json(performance_data)
                
                await asyncio.sleep(5)  # Update every 5 seconds
                
        except WebSocketDisconnect:
            active_connections.pop(connection_id, None)
            logging.info(f"WebSocket connection {connection_id} disconnected")
    
    @app.websocket("/ws/alerts")
    async def websocket_alerts(websocket: WebSocket):
        """WebSocket endpoint for optimization alerts and notifications."""
        await websocket.accept()
        connection_id = f"alerts_{id(websocket)}"
        active_connections[connection_id] = websocket
        
        try:
            while True:
                # Send optimization alerts
                if demand_optimizer:
                    alerts = await demand_optimizer.get_active_alerts()
                    if alerts:
                        await websocket.send_json(alerts)
                
                await asyncio.sleep(10)  # Check alerts every 10 seconds
                
        except WebSocketDisconnect:
            active_connections.pop(connection_id, None)
            logging.info(f"WebSocket connection {connection_id} disconnected")
    
    @app.get("/")
    async def root():
        """Root endpoint with service information."""
        return {
            "service": "IZA OS Inventory Management Optimization Bot",
            "version": "1.0.0",
            "status": "operational",
            "description": "Advanced AI-powered inventory optimization and intelligence bot",
            "endpoints": {
                "optimization": "/api/v1/optimization",
                "algorithms": "/api/v1/algorithms",
                "health": "/api/v1/health",
                "websocket_optimization": "/ws/optimization",
                "websocket_performance": "/ws/performance",
                "websocket_alerts": "/ws/alerts"
            }
        }
    
    return app


def main():
    """Main entry point."""
    app = create_app()
    
    # Run the application
    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8082,
        log_level="info",
        access_log=True
    )


if __name__ == "__main__":
    main()
