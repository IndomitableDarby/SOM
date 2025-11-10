"""
 Copyright (C) 2015-2024, Som Inc.
 Created by Som, Inc. <info@som.com>.
 This program is free software; you can redistribute it and/or modify it under the terms of GPLv2
"""
import pytest
import sys

from som_testing.tools.monitors import file_monitor
from som_testing.modules.modulesd.sca import patterns
from som_testing.constants.paths.logs import SOM_LOG_PATH
from som_testing.utils import callbacks
from som_testing.constants.platforms import WINDOWS


# Fixtures
@pytest.fixture()
def wait_for_sca_enabled():
    '''
    Wait for the sca module to start.
    '''
    log_monitor = file_monitor.FileMonitor(SOM_LOG_PATH)
    log_monitor.start(callback=callbacks.generate_callback(patterns.CB_SCA_ENABLED), timeout=60 if sys.platform == WINDOWS else 10)
    assert log_monitor.callback_result
