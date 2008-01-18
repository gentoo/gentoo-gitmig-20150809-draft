# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nsplugins/nsplugins-4.0.0.ebuild,v 1.1 2008/01/18 01:46:49 ingmar Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="Netscape plugins support for Konqueror."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/konqueror-${PV}:${SLOT}
	x11-libs/libXt"
RDEPEND="${DEPEND}"
