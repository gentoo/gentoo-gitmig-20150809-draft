# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.6.3.ebuild,v 1.3 2003/09/06 23:51:37 msterret Exp $

inherit gnome2

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.7.4
	>=net-libs/linc-1
	dev-util/indent"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14"

DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"

MAKEOPTS="${MAKEOPTS} -j1"

