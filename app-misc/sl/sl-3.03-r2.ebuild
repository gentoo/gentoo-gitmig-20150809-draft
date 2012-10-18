# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sl/sl-3.03-r2.ebuild,v 1.1 2012/10/18 08:51:44 kensington Exp $

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

SL_PATCH="sl5-1.patch"

DESCRIPTION="sophisticated graphical program which corrects your miss typing"
HOMEPAGE="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/ http://www.izumix.org.uk/sl/"
SRC_URI="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/sl/${PN}.tar
	http://www.linet.gr.jp/~izumi/sl/${SL_PATCH}
	http://www.sodan.ecc.u-tokyo.ac.jp/~okayama/sl/${PN}.en.1.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug linguas_ja"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	tc-export CC
	use debug && append-cppflags -DDEBUG
}

src_prepare() {
	epatch -p1 "${DISTDIR}/${SL_PATCH}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/Makefile.patch"
	epatch "${FILESDIR}/fix_compilation.patch"

	if use linguas_ja; then
		iconv -f ISO-2022-JP -t EUC-JP sl.1 > sl.ja.1
	fi
}

src_install() {
	dobin sl

	newman "${WORKDIR}/sl.en.1" sl.1
	dodoc sl.txt

	if use linguas_ja ; then
		dodoc README*
		insinto /usr/share/man/ja/man1
		newins sl.ja.1 sl.1
	fi
}
