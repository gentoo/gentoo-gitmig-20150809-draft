# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.4.1.ebuild,v 1.9 2003/02/13 12:04:00 vapier Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
SRC_URI="mirror://gnome/2.0.0/sources/ORBit2/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

MAKEOPTS="-j1"

RDEPEND=">=dev-libs/glib-2.0.6
		>=dev-libs/popt-1.6.3
		>=dev-libs/libIDL-0.7.4
		>=net-libs/linc-0.5.2"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"


DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"
