# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.0.0-r1.ebuild,v 1.11 2003/07/19 23:22:44 tester Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="libgtop"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha amd64"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog  INSTALL LIBGTOP-VERSION NEWS README RELNOTES*"





