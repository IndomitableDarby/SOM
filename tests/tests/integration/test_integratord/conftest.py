'''
copyright: Copyright (C) 2015-2024, Som Inc.
           Created by Som, Inc. <info@som.com>.
           This program is free software; you can redistribute it and/or modify it under the terms of GPLv2
'''
import pytest

from som_testing.constants.paths.logs import SOM_LOG_PATH
from som_testing.modules.integratord.patterns import INTEGRATORD_CONNECTED
from som_testing.tools.monitors.file_monitor import FileMonitor
from som_testing.utils import callbacks


@pytest.fixture()
def wait_for_integratord_start(request):
    # Wait for integratord thread to start
    log_monitor = FileMonitor(SOM_LOG_PATH)
    log_monitor.start(callback=callbacks.generate_callback(INTEGRATORD_CONNECTED))
    assert (log_monitor.callback_result == None), f'Error invalid configuration event not detected'
