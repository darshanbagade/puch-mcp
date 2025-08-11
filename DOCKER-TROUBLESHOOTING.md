# 🔧 Docker Build Troubleshooting Guide

## Dependency Conflict Resolution

### Problem: pip dependency conflicts
```
ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/latest/topics/dependency-resolution/#dealing-with-dependency-conflicts
```

### Solutions (try in order):

#### 1. Use Updated Requirements (Recommended)
The main `requirements.txt` has been updated with compatible versions:
```bash
docker build -t mcp-server .
```

#### 2. Use Minimal Dependencies
If main requirements still fail, use minimal version:
```bash
docker build -f Dockerfile.minimal -t mcp-server .
```

#### 3. Manual Dependency Resolution
Create a custom requirements file:
```txt
# requirements-custom.txt
fastmcp[streamable-http]
httpx>=0.28.1
python-dotenv
google-generativeai
Pillow
beautifulsoup4
pydantic
```

Then modify Dockerfile:
```dockerfile
COPY requirements-custom.txt requirements.txt
```

#### 4. Force Upgrade Strategy
If conflicts persist, modify the Dockerfile pip command:
```dockerfile
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --upgrade-strategy eager -r requirements.txt
```

#### 5. Use Poetry or Pipenv (Advanced)
For complex dependency management:
```bash
# Install poetry
pip install poetry

# Initialize and add dependencies
poetry init
poetry add fastmcp[streamable-http] httpx python-dotenv google-generativeai Pillow beautifulsoup4 pydantic

# Export to requirements.txt
poetry export -f requirements.txt --output requirements.txt
```

## Common Dependency Issues

### FastMCP Version Conflicts
- **Issue**: `fastmcp 2.11.2` requires `httpx>=0.28.1`
- **Solution**: Update httpx: `httpx>=0.28.1`

### Pydantic Version Issues
- **Issue**: Pydantic v3 incompatibility
- **Solution**: Pin to v2: `pydantic>=2.8.2,<3.0.0`

### Python Version Compatibility
- **Issue**: Some packages require Python 3.11+
- **Solution**: Use `FROM python:3.11-slim` in Dockerfile

## Testing Your Fix

### Local Test
```bash
# Test requirements locally first
pip install -r requirements.txt
python main.py
```

### Docker Test
```bash
# Test Docker build
docker build -t mcp-test .

# Test with minimal resources
docker run --rm -e AUTH_TOKEN=test -e GEMINI_API_KEY=test -e MY_NUMBER=test mcp-test
```

## Alternative Approaches

### 1. Multi-stage Build
```dockerfile
# Stage 1: Dependencies
FROM python:3.11-slim as deps
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim
COPY --from=deps /root/.local /root/.local
COPY main.py .
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "main.py"]
```

### 2. Use Pre-built Base Images
```dockerfile
FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim
# uv handles dependencies better than pip
```

### 3. Conda Environment
```dockerfile
FROM continuumio/miniconda3
COPY environment.yml .
RUN conda env create -f environment.yml
```

## Getting Help

If issues persist:
1. Check FastMCP documentation: https://gofastmcp.com
2. Review Python packaging guides: https://packaging.python.org
3. Use dependency visualization: `pip-tree` or `pipdeptree`

## Quick Fixes Summary

```bash
# Try these in order:
1. docker build -t mcp-server .                    # Updated requirements
2. docker build -f Dockerfile.minimal -t mcp-server .   # Minimal deps
3. # Edit requirements.txt to remove version pins
4. # Use --upgrade-strategy eager in Dockerfile
```
