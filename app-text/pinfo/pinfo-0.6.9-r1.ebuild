# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pinfo/pinfo-0.6.9-r1.ebuild,v 1.7 2010/12/28 15:32:38 ranger Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Hypertext info and man viewer based on (n)curses"
HOMEPAGE="http://pinfo.alioth.debian.org/"
SRC_URI="http://alioth.debian.org/download.php/1498/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="nls readline"

RDEPEND="sys-libs/ncurses
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	sys-devel/bison
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-FTPVIEWER.patch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-GROFF_NO_SGR.patch \
		"${FILESDIR}"/${P}-lzma-xz.patch \
		"${FILESDIR}"/${P}-version.patch
	AT_M4DIR="${S}/macros" eautoreconf
}

src_configure() {
	econf \
		$(use_with readline) \
		$(use_enable nls) \
		|| die "econf failed"
}

src_install() {
	make DESTDIR="${D}" sysconfdir=/etc install || die
}
