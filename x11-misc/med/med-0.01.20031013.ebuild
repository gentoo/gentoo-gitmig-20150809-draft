# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/med/med-0.01.20031013.ebuild,v 1.3 2004/01/26 01:14:11 vapier Exp $

inherit enlightenment

DESCRIPTION="E17 prototype menu editor"

DEPEND="${DEPEND}
	virtual/x11
	>=media-libs/ebits-1.0.1.20031013
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/evas-1.0.0.20031013_pre12"
