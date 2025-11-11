/*
 * Som Inventory Harvester - Upsert element
 * Copyright (C) 2015, Som Inc.
 * August 16, 2025.
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public
 * License (version 2) as published by the FSF - Free Software
 * Foundation.
 */

#ifndef _INVENTORY_BROWSER_EXTENSION_HARVESTER_HPP
#define _INVENTORY_BROWSER_EXTENSION_HARVESTER_HPP

#include "reflectiveJson.hpp"
#include "wcsClasses/agent.hpp"
#include "wcsClasses/browserExtension.hpp"
#include "wcsClasses/som.hpp"

struct InventoryBrowserExtensionHarvester final
{
    Agent agent;
    BrowserExtension::Browser browser;
    Som som;
    BrowserExtension::File file;
    BrowserExtension::Package package;
    BrowserExtension::User user;

    REFLECTABLE(MAKE_FIELD("browser", &InventoryBrowserExtensionHarvester::browser),
                MAKE_FIELD("file", &InventoryBrowserExtensionHarvester::file),
                MAKE_FIELD("package", &InventoryBrowserExtensionHarvester::package),
                MAKE_FIELD("user", &InventoryBrowserExtensionHarvester::user),
                MAKE_FIELD("agent", &InventoryBrowserExtensionHarvester::agent),
                MAKE_FIELD("som", &InventoryBrowserExtensionHarvester::som));
};

#endif // _INVENTORY_BROWSER_EXTENSION_HARVESTER_HPP
