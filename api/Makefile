# Makefile for Som API
# Copyright (C) 2025, Som Inc.
# Syntax: make [ all | backup | install | restore | service ]

SOM_GROUP       = som
INSTALLDIR       ?= /var/ossec

MV_FILE        = mv -f
RM_FILE        = rm -f
INSTALL_DIR    = install -o root -g ${SOM_GROUP} -m 0750 -d
INSTALL_RW_DIR = install -o root -g ${SOM_GROUP} -m 0770 -d
INSTALL_EXEC   = install -o root -g ${SOM_GROUP} -m 0750
INSTALL_FILE   = install -o root -g ${SOM_GROUP} -m 0640
INSTALL_CONFIG_FILE   = install -o root -g ${SOM_GROUP} -m 0660
PYTHON_BIN     = $(INSTALLDIR)/framework/python/bin/python3


.PHONY: all backup install restore

all: backup install restore

backup:
	# Backup previous configuration
	. ../api/service/inst-api-functions.sh; backup_old_api ${REVISION}

install:
    # Copy files and create folders
	$(INSTALL_DIR) $(INSTALLDIR)/api
	$(INSTALL_RW_DIR) $(INSTALLDIR)/api/configuration
	$(INSTALL_RW_DIR) $(INSTALLDIR)/api/configuration/ssl
	$(INSTALL_RW_DIR) $(INSTALLDIR)/api/configuration/security

	$(INSTALL_CONFIG_FILE) api/configuration/api.yaml ${INSTALLDIR}/api/configuration

	$(INSTALL_DIR) $(INSTALLDIR)/api/scripts
	$(INSTALL_FILE) scripts/som_apid.py ${INSTALLDIR}/api/scripts

    # Install scripts/%.py on $(INSTALLDIR)/bin/%
	$(foreach script,$(wildcard scripts/*.py),$(INSTALL_EXEC) wrappers/generic_wrapper.sh $(patsubst scripts/%.py,$(INSTALLDIR)/bin/%,$(script));)
	
	$(MV_FILE) $(INSTALLDIR)/bin/som_apid $(INSTALLDIR)/bin/som-apid

restore:
    # Restore old API config
	. ../api/service/inst-api-functions.sh; restore_old_api ${REVISION}
