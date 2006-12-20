# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.0.7_beta1.ebuild,v 1.2 2006/12/20 23:24:23 flameeyes Exp $

inherit toolchain-funcs eutils perl-app distutils

MY_PV="${PV//./}"
MY_P="nkf${MY_PV/_beta/b}"
DESCRIPTION="Network Kanji code conversion Filter with UTF-8/16 support"
HOMEPAGE="http://sourceforge.jp/projects/nkf/"
SRC_URI="mirror://sourceforge.jp/nkf/20055/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="perl linguas_ja"
#IUSE="${IUSE} python"

DEPEND=""

S="${WORKDIR}/${MY_P%%b*}"

src_unpack() {
	unpack ${A}

	sed -i -e '/-o nkf/s:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' \
		"${S}/Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" nkf || die
	if use perl; then
		cd "${S}/NKF.mod"
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
	if use linguas_ja; then
		./nkf -e nkf.1j > nkf.1
		doman -i18n=ja nkf.1
	fi
	dodoc INSTALL* nkf.doc
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_install
	fi
	#if use python; then
	#	cd ${S}/NKF.python
	#	distutils_src_install
	#fi
}
