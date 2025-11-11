/*
 * Som inventory harvester
 * Copyright (C) 2015, Som Inc.
 * January 14, 2025.
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public
 * License (version 2) as published by the FSF - Free Software
 * Foundation.
 */

#ifndef _INVENTORY_PROCESS_HARVESTER_HPP
#define _INVENTORY_PROCESS_HARVESTER_HPP

#include "reflectiveJson.hpp"
#include "wcsClasses/agent.hpp"
#include "wcsClasses/process.hpp"
#include "wcsClasses/som.hpp"

struct InventoryProcessHarvester final
{
    Agent agent;
    Process process;
    Som som;

    REFLECTABLE(MAKE_FIELD("process", &InventoryProcessHarvester::process),
                MAKE_FIELD("agent", &InventoryProcessHarvester::agent),
                MAKE_FIELD("som", &InventoryProcessHarvester::som));
};

#endif // _INVENTORY_PROCESS_HARVESTER_HPP
