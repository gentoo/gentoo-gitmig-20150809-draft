# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/enhance/enhance-9999.ebuild,v 1.1 2006/02/11 05:21:25 vapier Exp $

ECVS_MODULE="e17/proto/enhance"
inherit enlightenment

DESCRIPTION="GUI developer for E17 using GLADE, EXML, and ETK"

DEPEND="dev-libs/exml
	x11-libs/ecore
	x11-libs/etk"
