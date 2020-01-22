#!/bin/sh

# 检测 CVE-2008-1927 补丁是否已经生效
rpm -q --changelog perl | grep CVE-2008-1927
