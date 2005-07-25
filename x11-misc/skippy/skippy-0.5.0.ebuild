# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/skippy/skippy-0.5.0.ebuild,v 1.7 2005/07/25 23:20:40 smithj Exp $

inherit eutils

IUSE=""

DESCRIPTION="A full-screen task-switcher providing Apple Expose-like functionality with various WMs"
HOMEPAGE="http://thegraveyard.org/skippy.php"
SRC_URI="http://thegraveyard.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/x11
	virtual/xft"

DEPEND="${RDEPEND}
	>=media-libs/imlib2-1.1.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-pointer-size.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die

	insinto /usr/share/${P}
	doins skippyrc-default

	dodoc CHANGELOG
}


pkg_postinst() {
	einfo
	einfo "You should copy /usr/share/${P}/skippyrc-default to ~/.skippyrc"
	einfo "and edit the keysym used to invoke skippy"
	einfo "(Find out the keysym name using 'xev')"
	einfo
	echo
}

