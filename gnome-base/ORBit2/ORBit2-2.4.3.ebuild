# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.4.3.ebuild,v 1.2 2002/09/13 15:24:22 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
SRC_URI="mirror://gnome/2.0.1/sources/ORBit2/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

MAKEOPTS="-j1"

RDEPEND=">=dev-libs/glib-2.0.6
		>=dev-libs/popt-1.6.3
		>=dev-libs/libIDL-0.8.0
		>=net-libs/linc-0.5.3"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 sparc sparc64 ppc"


DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"
