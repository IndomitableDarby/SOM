/*
 * Som inventory harvester
 * Copyright (C) 2015, Som Inc.
 * March 20, 2025.
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public
 * License (version 2) as published by the FSF - Free Software
 * Foundation.
 */

#ifndef _INVENTORY_HARDWARE_HARVESTER_HPP
#define _INVENTORY_HARDWARE_HARVESTER_HPP

#include "reflectiveJson.hpp"
#include "wcsClasses/agent.hpp"
#include "wcsClasses/hardware.hpp"
#include "wcsClasses/som.hpp"

struct InventoryHardwareHarvester final
{
    Agent agent;
    Hardware host;
    Som som;

    REFLECTABLE(MAKE_FIELD("host", &InventoryHardwareHarvester::host),
                MAKE_FIELD("agent", &InventoryHardwareHarvester::agent),
                MAKE_FIELD("som", &InventoryHardwareHarvester::som));
};

#endif // _INVENTORY_HARDWARE_HARVESTER_HPP
