# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/epbb/epbb-0.0.5.20040124.ebuild,v 1.1 2004/01/25 04:19:25 vapier Exp $

inherit enlightenment

DESCRIPTION="a pbbuttonsd client using the EFL"

KEYWORDS="~ppc"

DEPEND=">=x11-libs/evas-1.0.0.20040117_pre12
	>=media-libs/edje-0.0.1.20040117
	>=x11-libs/ecore-1.0.0.20040117_pre4
	>=sys-apps/pbbuttonsd-0.5.2"
