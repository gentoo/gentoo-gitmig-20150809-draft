# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sl/sl-3.03.ebuild,v 1.1 2003/09/07 15:22:48 usata Exp $

inherit eutils

IUSE="cjk"

SL_PATCH="sl5-1.patch"

DESCRIPTION="SL is a sophisticated graphical program which corrects your miss typing"
HOMEPAGE="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/
	http://www.linet.gr.jp/~izumi/sl/"
SRC_URI="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/sl/${PN}.tar
	http://www.linet.gr.jp/~izumi/sl/${SL_PATCH}
	http://www.sodan.ecc.u-tokyo.ac.jp/~okayama/sl/${PN}.en.1.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc"

DEPEND="virtual/glibc
	sys-libs/ncurses
	cjk? ( app-i18n/nkf )"
RDEPEND="virtual/glibc
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
	if [ -n "`use cjk`" ]; then
		nkf -e sl.1 > sl.ja.1
	fi
}

src_install() {

	dobin sl
	newman sl.en.1 sl.1
	dodoc README* sl.txt
	if [ -n "`use cjk`" ] ; then
		insinto /usr/share/man/ja/man1
		newins sl.ja.1 sl.1
	fi
}
