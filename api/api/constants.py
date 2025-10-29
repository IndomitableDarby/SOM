# Copyright (C) 2025, Som Inc.
# Created by Som, Inc. <info@som.com>.
# This program is a free software; you can redistribute it and/or modify it under the terms of GPLv2

import os

from som.core import common

API_PATH = os.path.join(common.SOM_PATH, 'api')
CONFIG_PATH = os.path.join(API_PATH, 'configuration')
CONFIG_FILE_PATH = os.path.join(CONFIG_PATH, 'api.yaml')
RELATIVE_CONFIG_FILE_PATH = os.path.relpath(CONFIG_FILE_PATH, common.SOM_PATH)
SECURITY_PATH = os.path.join(CONFIG_PATH, 'security')
SECURITY_CONFIG_PATH = os.path.join(SECURITY_PATH, 'security.yaml')
RELATIVE_SECURITY_PATH = os.path.relpath(SECURITY_PATH, common.SOM_PATH)
API_LOG_PATH = os.path.join(common.SOM_PATH, 'logs', 'api')
API_SSL_PATH = os.path.join(CONFIG_PATH, 'ssl')
INSTALLATION_UID_PATH = os.path.join(SECURITY_PATH, 'installation_uid')
INSTALLATION_UID_KEY = 'installation_uid'
UPDATE_INFORMATION_KEY = 'update_information'
