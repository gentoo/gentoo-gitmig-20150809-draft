# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.0.7_beta1.ebuild,v 1.1 2006/06/17 13:55:44 usata Exp $

inherit toolchain-funcs eutils perl-app distutils

MY_PV="${PV//./}"
MY_P="nkf${MY_PV/_beta/b}"
DESCRIPTION="Network Kanji code conversion Filter with UTF-8/16 support"
HOMEPAGE="http://sourceforge.jp/projects/nkf/"
SRC_URI="mirror://sourceforge.jp/nkf/20055/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="perl cjk"
#IUSE="${IUSE} python"

DEPEND="virtual/libc"

S="${WORKDIR}/${MY_P%%b*}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" nkf || die
	if use perl; then
		cd ${S}/NKF.mod
		perl-module_src_compile
		perl-module_src_test
	fi
	#if use python; then
	#	cd ${WORKDIR}
	#	epatch ${FILESDIR}/nkf-python.patch
	#	cd ${S}/NKF.python
	#	distutils_src_compile
	#	src_test
	#fi
}

src_install() {
	dobin nkf || die
	doman nkf.1
	if use cjk; then
		dodir /usr/share/man/ja/man1
		insinto /usr/share/man/ja/man1
		./nkf -e nkf.1j > nkf.1
		doins nkf.1
	fi
	dodoc INSTALL* nkf.doc
	if use perl; then
		cd ${S}/NKF.mod
		perl-module_src_install
	fi
	#if use python; then
	#	cd ${S}/NKF.python
	#	distutils_src_install
	#fi
}
