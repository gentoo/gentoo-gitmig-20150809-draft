# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcli/libcli-1.9.0.ebuild,v 1.1 2007/09/22 00:14:13 aross Exp $

inherit multilib toolchain-funcs

DESCRIPTION="Cisco-style (telnet) command-line interface library"

HOMEPAGE="http://sourceforge.net/projects/libcli"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	# Support /lib{32,64}
	sed -i 's:$(PREFIX)/lib:$(libdir):g' "${S}"/Makefile
	sed -i 's:PREFIX = /usr/local:&\nlibdir = $(PREFIX)/lib:' "${S}"/Makefile
}

src_compile() {
	emake OPTIM="" DEBUG="" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" \
		PREFIX=/usr \
		OPTIM="" \
		DEBUG="" \
		libdir="/usr/$(get_libdir)" \
		install || die "emake install failed"

	dobin clitest

	dohtml Doc/*
	dodoc README
}
