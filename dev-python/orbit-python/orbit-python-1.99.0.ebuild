# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/orbit-python/orbit-python-1.99.0.ebuild,v 1.7 2004/06/25 01:35:44 agriffis Exp $

inherit gnome2 debug

IUSE=""
DESCRIPTION="Orbit bindings for Python"
HOMEPAGE="http://orbit-python.sault.org/"

DEPEND=">=dev-lang/python-2.2
	>=net-libs/linc-0.1.6
	>=gnome-base/ORBit2-2.3.103
	>=dev-libs/libIDL-0.7.1
	>=dev-libs/glib-1.3.10"

RDEPEND="${DEPEND} >=dev-util/pkgconfig-0.12.0"

SLOT="2"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
