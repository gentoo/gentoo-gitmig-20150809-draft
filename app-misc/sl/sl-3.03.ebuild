# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sl/sl-3.03.ebuild,v 1.10 2004/10/23 08:14:23 mr_bones_ Exp $

inherit eutils

SL_PATCH="sl5-1.patch"

DESCRIPTION="sophisticated graphical program which corrects your miss typing"
HOMEPAGE="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/ http://www.linet.gr.jp/~izumi/sl/"
SRC_URI="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/sl/${PN}.tar
	http://www.linet.gr.jp/~izumi/sl/${SL_PATCH}
	http://www.sodan.ecc.u-tokyo.ac.jp/~okayama/sl/${PN}.en.1.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 alpha ~sparc ppc64 ppc ppc-macos"
IUSE="cjk"

DEPEND="virtual/libc
	sys-libs/ncurses
	!macos? ( !ppc-macos? ( cjk? ( app-i18n/nkf ) ) )"
RDEPEND="virtual/libc
	sys-libs/ncurses"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${PN}.tar
	cd ${S}
	epatch ${DISTDIR}/${SL_PATCH}
	epatch ${FILESDIR}/${P}-gentoo.diff
	unpack ${PN}.en.1.gz
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="-lncurses" || die
	if use cjk; then
		nkf -e sl.1 > sl.ja.1
	fi
}

src_install() {
	dobin sl || die
	newman sl.en.1 sl.1
	dodoc README* sl.txt
	if use cjk ; then
		insinto /usr/share/man/ja/man1
		newins sl.ja.1 sl.1
	fi
}
