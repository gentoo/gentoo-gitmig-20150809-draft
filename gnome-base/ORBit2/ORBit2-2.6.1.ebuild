# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.6.1.ebuild,v 1.5 2003/04/26 17:34:29 liquidx Exp $

inherit gnome2 

S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"

MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.7.4
	>=net-libs/linc-1.0.0
	dev-util/indent"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha sparc"

DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"
