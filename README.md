# Data Analysis Project Setup

This project provides a development environment with Jupyter Notebook, TimescaleDB, and Adminer for data analysis.

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your machine
- VSCode with Jupyter extension (optional, for connecting to Jupyter server)

### Setup and Run

1. Clone this repository or create the files as shown below
2. Make sure these files are in your project directory:
   - `docker-compose.yml`
   - `Dockerfile`
   - `requirements.txt`
   - Create a `notebooks` directory
3. Run the following command to start all services:

```bash
docker-compose up --build
```

### Accessing Services

Once the containers are running, you can access:

- **Jupyter Lab**: http://localhost:8888
  - No password is required (for development purposes)
- **Adminer**: http://localhost:8080
  - System: PostgreSQL
  - Server: timescaledb
  - Username: postgres
  - Password: postgres
  - Database: analysis
- **TimescaleDB**: 
  - Host: localhost
  - Port: 5432
  - Username: postgres
  - Password: postgres
  - Database: analysis

### Connecting to Jupyter from VSCode

#### Method 1: Using the .vscode/settings.json file (Recommended)

1. Open VSCode in the same directory as your project 
2. Install the "Jupyter" extension if you haven't already
3. The `.vscode/settings.json` file should automatically configure the connection
4. Open any notebook file (.ipynb) in the notebooks directory
5. When prompted for a kernel, select "Remote Jupyter Kernel"
6. If no kernel appears, try clicking "Select Another Kernel..." and choose "Existing Jupyter Server"
7. Enter `http://localhost:8888` as the server URL (no token required)

#### Method 2: Manual Configuration

If Method 1 doesn't work, try the following:

1. Open VSCode
2. Install the "Jupyter" extension if you haven't already
3. Open the Command Palette (Ctrl+Shift+P or Cmd+Shift+P)
4. Type and select "Jupyter: Specify Jupyter Server for Connections"
5. Enter `http://localhost:8888` as the server URL
6. Leave the token field empty and press Enter
7. Open any notebook (.ipynb file)
8. When asked for a kernel, choose one from the remote server

### Project Structure

```
project/
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile            # Container definition
├── requirements.txt      # Python dependencies
├── notebooks/            # Store your Jupyter notebooks here
│   └── example_connection.ipynb  # Example notebook
└── README.md             # Project documentation
```

### Custom Modifications

- If you need to add more Python packages, add them to `requirements.txt` and rebuild the container
- To persist more data, add additional volume mounts in `docker-compose.yml`
- To secure Jupyter in production, modify the command in `docker-compose.yml` to set a password

### Troubleshooting

#### VSCode Can't Connect to Jupyter Kernel

1. **Verify the container is running**: Run `docker ps` to ensure the Jupyter container is up
2. **Check Jupyter logs**: Run `docker logs data_analysis_jupyter` to see any errors
3. **Try direct browser access**: Go to http://localhost:8888 to confirm Jupyter is accessible
4. **Reset VSCode Jupyter connection**:
   - Open Command Palette (Ctrl+Shift+P)
   - Run "Jupyter: Clear Jupyter Cache and Restart"
   - Try connecting again
5. **Restart the container**: Run `docker-compose restart jupyter`

#### Git Not Working in Jupyter

If git commands still fail after adding git to the Dockerfile:
1. Rebuild the container: `docker-compose up --build`
2. Configure git (one-time setup):
   ```bash
   docker exec -it data_analysis_jupyter bash -c "git config --global user.email 'you@example.com' && git config --global user.name 'Your Name'"
   ```

## Working with TimescaleDB

TimescaleDB extends PostgreSQL with time-series capabilities. Key features include:

- Hypertables for efficient time-series storage
- Time-based partitioning
- Advanced time-series functions
- Retention policies

See the example notebook (`example_connection.ipynb`) for basic usage.
