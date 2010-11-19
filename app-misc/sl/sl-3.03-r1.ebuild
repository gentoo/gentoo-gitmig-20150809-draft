# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sl/sl-3.03-r1.ebuild,v 1.2 2010/11/19 15:14:25 tomka Exp $

EAPI=3

inherit eutils toolchain-funcs flag-o-matic

SL_PATCH="sl5-1.patch"

DESCRIPTION="sophisticated graphical program which corrects your miss typing"
HOMEPAGE="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/ http://www.izumix.org.uk/sl/"
SRC_URI="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/sl/${PN}.tar
	http://www.linet.gr.jp/~izumi/sl/${SL_PATCH}
	http://www.sodan.ecc.u-tokyo.ac.jp/~okayama/sl/${PN}.en.1.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="linguas_ja debug"

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${DISTDIR}/${SL_PATCH}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/Makefile.patch"
	epatch "${FILESDIR}/fix_compilation.patch"
}

src_compile() {
	use debug && append-flags -DDEBUG

	emake CC=$(tc-getCC) || die

	if use linguas_ja; then
		iconv -f ISO-2022-JP -t EUC-JP sl.1 > sl.ja.1
	fi
}

src_install() {
	dobin sl || die

	newman "${WORKDIR}/sl.en.1" sl.1
	dodoc sl.txt

	if use linguas_ja ; then
		dodoc README*
		insinto /usr/share/man/ja/man1
		newins sl.ja.1 sl.1
	fi
}
