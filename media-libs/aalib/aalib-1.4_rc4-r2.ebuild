# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc4-r2.ebuild,v 1.11 2003/06/11 22:26:00 liquidx Exp $

IUSE="X slang gpm"

inherit libtool

MY_P="${P/_/}"
S="${WORKDIR}/${PN}-1.4.0"
DESCRIPTION="A ASCII-Graphics Library"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"
HOMEPAGE="http://aa-project.sourceforge.net/aalib/"

DEPEND=">=sys-libs/ncurses-5.1
	X?	 ( virtual/x11 )
	gpm?   ( sys-libs/gpm )
	slang? ( >=sys-libs/slang-1.4.2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

pkg_setup() {

	# We need autoconf-2.5
	export WANT_AUTOCONF_2_5=1
}

src_unpack() {

	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
	touch *
}

src_compile() {

	local myconf=""
	use slang \
		&& myconf="--with-slang-driver=yes" \
		|| myconf="--with-slang-driver=no"
	
	use X \
		&& myconf="${myconf} --with-x11-driver=yes" \
		|| myconf="${myconf} --with-x11-driver=no"
	
	use gpm \
		&& myconf="${myconf} --with-gpm-mouse=no"

	elibtoolize

	econf ${myconf} || die
	emake || die
}

src_install() {

	einstall || die
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*
}
