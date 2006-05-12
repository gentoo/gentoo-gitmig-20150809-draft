# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openquicktime/openquicktime-1.0-r1.ebuild,v 1.13 2006/05/12 22:58:22 tcort Exp $

inherit flag-o-matic eutils
replace-flags "-fprefetch-loop-arrays" " "

MY_P=${P}-src
S=${WORKDIR}/${MY_P}
DESCRIPTION="OpenQuicktime library for linux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz
	mirror://gentoo/openquicktime-1.0-gcc34-1.patch.bz2"
HOMEPAGE="http://www.openquicktime.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="media-sound/lame
	virtual/mpg123
	=dev-libs/glib-1*
	!virtual/quicktime
	media-libs/jpeg"

PROVIDE="virtual/quicktime"

src_unpack () {
	unpack ${MY_P}.tgz
	cd ${S}
	if has_version '>=sys-devel/gcc-3.4'; then
		epatch ${DISTDIR}/${P}-gcc34-1.patch.bz2
	fi
}

src_compile() {
	# debug is enabled by default...
	econf --enable-debug=no || die
	emake || die
}

src_install() {
	cd ${S}
	dolib.so libopenquicktime.so
	dodoc README AUTHORS NEWS TODO
	dodir /usr/bin
	einstall || die
}
