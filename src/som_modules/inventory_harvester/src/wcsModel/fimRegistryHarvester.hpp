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

#ifndef _FIM_REGISTRY_HARVESTER_HPP
#define _FIM_REGISTRY_HARVESTER_HPP

#include "reflectiveJson.hpp"
#include "wcsClasses/agent.hpp"
#include "wcsClasses/event.hpp"
#include "wcsClasses/registry.hpp"
#include "wcsClasses/som.hpp"

struct FimRegistryInventoryHarvester final
{
    Agent agent;
    Registry registry;
    Som som;
    Event event;

    REFLECTABLE(MAKE_FIELD("agent", &FimRegistryInventoryHarvester::agent),
                MAKE_FIELD("registry", &FimRegistryInventoryHarvester::registry),
                MAKE_FIELD("som", &FimRegistryInventoryHarvester::som),
                MAKE_FIELD("event", &FimRegistryInventoryHarvester::event));
};

#endif // _FIM_REGISTRY_HARVESTER_HPP
