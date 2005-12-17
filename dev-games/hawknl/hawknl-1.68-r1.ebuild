# Copyright 1999-2005 Gentoo Foundation, 2004 Richard Garand <richard@garandnet.net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/hawknl/hawknl-1.68-r1.ebuild,v 1.5 2005/12/17 03:09:42 vapier Exp $

inherit toolchain-funcs eutils multilib

DESCRIPTION="A cross-platform network library designed for games"
HOMEPAGE="http://www.hawksoft.com/hawknl/"
SRC_URI="http://www.sonic.net/~philf/download/HawkNL${PV/./}src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/hawknl${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	sed -i \
		-e '/echo /d' src/makefile.linux \
		|| die "sed src/makefile.linux failed"
}

src_compile() {
	emake -C src -f makefile.linux \
		CC="$(tc-getCC)" \
		OPTFLAGS="${CFLAGS} -D_GNU_SOURCE -D_REENTRANT" \
		|| die "emake failed"
}

src_install() {
	make -C src -f makefile.linux \
		LIBDIR="${D}/usr/$(get_libdir)" \
		INCDIR="${D}/usr/include" \
		install \
		|| die "make install failed"
	if use doc ; then
		docinto samples
		dodoc samples/* || die "dodoc failed"
	fi
}
