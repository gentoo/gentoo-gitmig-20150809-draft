# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-2.12.5.ebuild,v 1.9 2006/04/21 20:24:10 tcort Exp $

inherit gnome2

MY_P="ORBit2-${PV}"
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/ORBit2/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc ssl static"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.8.2
	ssl? ( >=dev-libs/openssl-0.9.6 )"

# FIXME linc is now integrated, but a block isn't necessary
# and probably complicated FIXME

# FIXME ssl is optional, but not switchable

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14
	doc? ( >=dev-util/gtk-doc-1 )"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"


pkg_setup() {
	G2CONF="$(use_enable static)"
}
