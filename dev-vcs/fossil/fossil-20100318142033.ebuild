# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fossil/fossil-20100318142033.ebuild,v 1.1 2010/05/19 07:52:44 jlec Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P="${PN}-src-${PV}"

DESCRIPTION="simple, high-reliability, distributed software configuration management"
HOMEPAGE="http://www.fossil-scm.org/"
SRC_URI="http://www.fossil-scm.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/openssl
	sys-libs/zlib"
RDEPEND=${DEPEND}

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	sed -i \
		-e "/^TCC *=/s:=.*:=$(tc-getCC) -Wall \$(CFLAGS) \$(CPPFLAGS):" \
		-e "/^BCC/s:gcc:$(tc-getBUILD_CC):" \
		Makefile || die
}

src_install() {
	dobin fossil || die
	dodoc ci_cvs.txt ci_fossil.txt cvs2fossil.txt || die
}
