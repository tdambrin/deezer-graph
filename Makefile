# Makefile for Vue.js Project

# Variables
NODE_MODULES = node_modules
DIST_DIR = dist

# Commands
install:
	@echo "Installing dependencies..."
	npm install

dev:
	@echo "Starting development server..."
	npm run dev

build:
	@echo "Building the project for production..."
	npm run build

lint:
	@echo "Linting the code..."
	npm run lint

test:
	@echo "Running tests..."
	npm run test

clean:
	@echo "Cleaning up..."
	rm -rf $(NODE_MODULES) $(DIST_DIR)

reinstall: clean install
	@echo "Reinstalled dependencies."

serve:
	@echo "Serving the production build..."
	npm run serve

help:
	@echo "Usage:"
	@echo "  make install      - Install dependencies"
	@echo "  make dev          - Start the development server"
	@echo "  make build        - Build the project for production"
	@echo "  make lint         - Run the linter"
	@echo "  make test         - Run the tests"
	@echo "  make clean        - Remove node_modules and dist directories"
	@echo "  make reinstall    - Clean and reinstall dependencies"
	@echo "  make serve        - Serve the production build locally"

.PHONY: install dev build lint test clean reinstall serve help
