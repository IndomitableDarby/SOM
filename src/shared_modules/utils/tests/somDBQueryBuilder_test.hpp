/*
 * Som shared modules utils
 * Copyright (C) 2015, Som Inc.
 * Nov 1, 2023.
 *
 * This program is free software; you can redistribute it
 * and/or modify it under the terms of the GNU General Public
 * License (version 2) as published by the FSF - Free Software
 * Foundation.
 */

#ifndef _SOM_DB_QUERY_BUILDER_TEST_HPP
#define _SOM_DB_QUERY_BUILDER_TEST_HPP

#include "gtest/gtest.h"

class SomDBQueryBuilderTest : public ::testing::Test
{
protected:
    SomDBQueryBuilderTest() = default;
    virtual ~SomDBQueryBuilderTest() = default;

    void SetUp() override {};
    void TearDown() override {};
};

#endif // _SOM_DB_QUERY_BUILDER_TEST_HPP
