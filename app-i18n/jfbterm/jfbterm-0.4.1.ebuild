# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jfbterm/jfbterm-0.4.1.ebuild,v 1.1 2003/09/04 01:47:36 usata Exp $

inherit flag-o-matic
replace-flags "-march=pentium3" "-mcpu=pentium3"

DESCRIPTION="The J Framebuffer Terminal/Multilingual Enhancement"
HOMEPAGE="http://jfbterm.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/5803/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/glibc
	>=sys-apps/sed-4
	sys-devel/autoconf
	sys-devel/automake
	sys-libs/ncurses"
RDEPEND="virtual/glibc"

src_compile() {

	# do some odd stuff ;-(
	OCC="${CC}"
	OCFLAGS="${CFLAGS}"
	unset CC CFLAGS
	econf || die "econf failed"
	# jfbterm peculiarly needs to be compiled twice.
	make CC="${OCC}" CFLAGS="${OCFLAGS}" || die "make failed"
	make CC="${OCC}" CFLAGS="${OCFLAGS}" || die "make failed"
	sed -i -e 's/a18/8x16/' jfbterm.conf.sample
}

src_install() {

	dodir /etc
	einstall || die

	if [ ! -e /usr/share/terminfo/j/jfbterm ] ; then
		dodir /usr/share/terminfo
		tic terminfo.jfbterm -o${D}/usr/share/terminfo || die
	fi

	mv ${D}/etc/jfbterm.conf{.sample,}

	doman jfbterm.1 jfbterm.conf.5

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc jfbterm.conf.sample*
}
