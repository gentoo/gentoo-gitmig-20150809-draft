# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/e/e-9999.ebuild,v 1.1 2004/12/11 23:22:49 vapier Exp $

ECVS_MODULE="e17/apps/e"
inherit enlightenment

DESCRIPTION="the e17 window manager"

DEPEND="sys-devel/libtool
	>=x11-libs/evas-9999
	>=x11-libs/ecore-9999
	>=media-libs/edje-9999
	>=dev-libs/eet-9999
	>=dev-libs/embryo-9999
	>=x11-libs/evas-9999"
