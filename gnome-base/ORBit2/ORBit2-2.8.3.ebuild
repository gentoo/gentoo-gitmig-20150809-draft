# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/ORBit2/ORBit2-2.8.3.ebuild,v 1.5 2004/01/29 04:46:19 agriffis Exp $

inherit gnome2

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

IUSE="doc ssl"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa amd64 ia64"

#MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.7.4
	dev-util/indent
	ssl? ( >=dev-libs/openssl-0.9.6 )"
# linc is now integrated, but a block isn't necessary
# and probably complicated FIXME

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog COPYING* README* HACKING INSTALL NEWS TODO MAINTAINERS"
