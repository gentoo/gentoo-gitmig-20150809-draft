# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/epbb/epbb-9999.ebuild,v 1.3 2006/08/25 07:15:04 vapier Exp $

ECVS_MODULE="misc/epbb"
inherit enlightenment

DESCRIPTION="a pbbuttonsd client using the EFL"

DEPEND=">=x11-libs/evas-0.9.9
	>=media-libs/edje-0.5.0
	>=x11-libs/ecore-0.9.9
	>=app-laptop/pbbuttonsd-0.5.2"
