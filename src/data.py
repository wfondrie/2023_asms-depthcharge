"""Update this module to download your data."""
import logging
from pathlib import Path

import click
import awswrangler as wr

DATA_DIR = Path(__file__).parent / "data"
LOGGER = logging.getLogger(__name__)

@click.Command()
def download():
    """Download data from Amazon S3 or other sources."""
    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s: %(message)s",
    )

    LOGGER.info("Update src/data.py to sync your data!")
