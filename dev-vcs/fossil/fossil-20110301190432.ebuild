# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fossil/fossil-20110301190432.ebuild,v 1.1 2011/03/08 19:22:34 rafaelmartins Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P="${PN}-src-${PV}"

DESCRIPTION="simple, high-reliability, distributed software configuration management"
HOMEPAGE="http://www.fossil-scm.org/"
SRC_URI="http://www.fossil-scm.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ssl"

DEPEND="sys-libs/zlib
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local tcc lib
	tcc="$(tc-getCC)"
	lib="${LDFLAGS} -lz"
	if use ssl; then
		tcc="${tcc} -DFOSSIL_ENABLE_SSL"
		lib="${lib} -lcrypto -lssl"
	fi
	emake TCC="${tcc}" BCC="$(tc-getBUILD_CC)" LIB="${lib}" || die 'emake failed.'
}

src_install() {
	dobin fossil || die 'dobin failed.'
	dodoc ci_cvs.txt ci_fossil.txt cvs2fossil.txt || die 'dodoc failed.'
}
