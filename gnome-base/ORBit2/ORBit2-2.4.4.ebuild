# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.4.4.ebuild,v 1.5 2003/02/13 12:04:08 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"

MAKEOPTS="-j1"

RDEPEND=">=dev-libs/glib-2.0.6
		>=dev-libs/popt-1.6.3
		>=dev-libs/libIDL-0.8.0
		>=net-libs/linc-0.5.5"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc alpha"


DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"
