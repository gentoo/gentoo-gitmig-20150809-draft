# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jfbterm/jfbterm-0.3.12.ebuild,v 1.5 2003/09/04 01:47:36 usata Exp $

inherit flag-o-matic
replace-flags "-march=pentium3" "-mcpu=pentium3"

DESCRIPTION="A Japanized framebuffer terminal with Multilingual Enhancement"
HOMEPAGE="http://jfbterm.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/1637/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc"

DEPEND=">=sys-apps/sed-4
	sys-devel/autoconf
	sys-devel/automake
	sys-libs/ncurses"
RDEPEND="virtual/glibc"

src_compile() {
	econf
	# jfbterm peculiarly needs to be compiled twice.
	emake || die "make failed"
	emake || die "make failed"
	sed -i 's/a18/8x16/' jfbterm.conf.sample
	sed -i '/^encoding/s/,,/,/' jfbterm.conf.sample
}

src_install() {
	dodir /etc
	einstall

	dodir /usr/share/terminfo
	tic terminfo.jfbterm -o${D}/usr/share/terminfo || die

	mv ${D}/etc/jfbterm.conf{.sample,}

	dodoc AUTHORS ChangeLog INSTALL NEWS README jfbterm.conf.sample
	dodoc ${FILESDIR}/jfbterm.conf.*
}
