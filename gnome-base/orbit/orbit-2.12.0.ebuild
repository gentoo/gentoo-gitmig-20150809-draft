# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/orbit/orbit-2.12.0.ebuild,v 1.11 2005/04/02 04:30:36 geoman Exp $

inherit gnome2 eutils

MY_P="ORBit2-${PV}"
PVP=(${PV//[-\._]/ })
S=${WORKDIR}/${MY_P}

DESCRIPTION="ORBit2 is a high-performance CORBA ORB"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/ORBit2/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/popt-1.5
	>=dev-libs/libIDL-0.8.2
	dev-util/indent
	ssl? ( >=dev-libs/openssl-0.9.6 )"

#libIDL dep in configure.in is wrong
#needs at least 0.8.2, see bug #73521 <joem@gentoo.org>

# FIXME linc is now integrated, but a block isn't necessary
# and probably complicated FIXME

# FIXME ssl is optional, but not switchable

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.14
	doc? ( >=dev-util/gtk-doc-1 )"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"

DOCS="AUTHORS ChangeLog README HACKING NEWS TODO MAINTAINERS"
