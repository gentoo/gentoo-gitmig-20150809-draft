# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/e_modules/e_modules-9999.ebuild,v 1.6 2006/09/14 15:21:04 vapier Exp $

ECVS_MODULE="e_modules"
inherit enlightenment

DESCRIPTION="add-on modules for e17 (snow/flame/notes/etc...)"

DEPEND="x11-wm/e
	x11-libs/ecore
	x11-libs/evas
	x11-libs/esmart
	media-libs/edje
	dev-libs/eet
	dev-libs/exml
	media-libs/alsa-lib
	x11-libs/libXdamage
	x11-libs/libXcomposite"
