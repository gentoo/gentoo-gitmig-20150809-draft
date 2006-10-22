# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/empower/empower-9999.ebuild,v 1.1 2006/10/22 02:29:10 vapier Exp $

ECVS_MODULE="e17/proto/empower"
inherit enlightenment

DESCRIPTION="graphical sudo application"

IUSE="nls"

DEPEND="dev-libs/eet
	x11-libs/ecore
	x11-libs/evas
	media-libs/edje
	|| ( x11-libs/etk x11-libs/ewl )"
