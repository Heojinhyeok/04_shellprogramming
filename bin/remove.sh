#!/bin/bash

lvremove /dev/vg1/lv1 -f
vgremove /dev/vg1
pvremove /dev/sdb1