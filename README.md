# Ensembl VEP (Variant Effect Predictor) example usage

This repository provides example usage of the [Ensembl Variant Effect Predictor](https://ensembl.org/info/docs/tools/vep/script/index.html) (VEP) ([src](https://github.com/Ensembl/ensembl-vep)) in both online and offline modes in the [official container image](https://hub.docker.com/r/ensemblorg/ensembl-vep).

### Prerequisites

1. [Docker](https://www.docker.com/products/docker-desktop) and [Docker Compose](https://docs.docker.com/compose/install/) installed.
2. [aria2c](https://aria2.github.io/) or [wget](https://www.gnu.org/software/wget/) for downloading data. The script will use `aria2c` if available, otherwise it will fall back to `wget`. The former reduces download time from 9 hours to 30 minutes for the 20GB cache.

### Directory Structure

Before running, ensure you have the following directory structure:

```
.
├── cache/  # VEP cache files will be stored here.
├── data/   # Your input data, i.e., rsids.txt should be placed here.
├── output/ # VEP results will be saved here.
├── vep.sh
└── docker-compose.yml
```

### Running VEP

1. Ensure `vep.sh` is executable:

   ```bash
   chmod +x vep.sh
   ```

2. You can run VEP in online mode (default) directly using:

   ```bash
   ./vep.sh
   ```

   To run in offline mode (utilizing local cache), set the `VEP_MODE` environment variable to "offline":

   ```bash
   VEP_MODE=offline ./vep.sh
   ```

   In offline mode, the script will first check if the VEP cache is available in the `cache/` directory. If not, it will download the cache files and extract them there.
   This is about 20GB and will take 30 minutes with aria2c or 9 hours with wget.

3. The output will be saved in the `output/` directory as `vep_output.txt`.

### Customizing the Input

To analyze a different set of variants:

1. Place your input file, such as `rsids.txt`, into the `data/` directory.
2. Modify the `input_file` path in the `docker-compose.yml` under the `command` section accordingly.

### Notes

- The Docker setup uses the official Ensembl VEP Docker image.
- Volumes are used to map local directories (`cache`, `data`, and `output`) to directories within the Docker container.
- The `docker-compose.yml` file specifies the Docker configurations and the commands to run VEP based on the mode (online/offline).

### Troubleshooting

- If you encounter issues with file permissions, check that your current user has appropriate permissions to read/write to the `cache`, `data`, and `output` directories.
- Ensure your input files are correctly formatted and placed in the `data/` directory before running the script.
