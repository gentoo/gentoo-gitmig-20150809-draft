# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfree.eclass,v 1.24 2004/11/24 16:55:51 spyderous Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The xfree.eclass is designed to ease the checking functions that are
# performed in xfree and xfree-drm ebuilds.  In the new scheme, a variable
# called VIDEO_CARDS will be used to indicate which cards a user wishes to
# build support for.  Note, that this variable is only unlocked if the USE
# variable "expertxfree" is switched on, at least for xfree.

inherit x11
