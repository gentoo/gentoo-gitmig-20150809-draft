# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/realpath/realpath-1.9.28.ebuild,v 1.5 2007/03/20 22:42:19 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Return the canonicalized absolute pathname"
HOMEPAGE="http://packages.debian.org/unstable/utils/realpath.html"
SRC_URI="mirror://debian/pool/main/d/dwww/dwww_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc-macos ~ppc64 ~sparc x86"
IUSE=""

# tests only operate upon things we don't use
RESTRICT="test"

RDEPEND="!sys-freebsd/freebsd-bin"

S=${WORKDIR}/dwww-${PV}

src_unpack() {
	if use userland_Darwin; then
		local dirname="dwww-${PV}"
		tar xzf ${DISTDIR}/${A} \
			${dirname}/Makefile \
			${dirname}/realpath.c \
			${dirname}/README \
			${dirname}/TODO \
			${dirname}/BUGS \
			${dirname}/man/realpath.1 || die "unpack failed."
	else
		unpack ${A}
	fi

	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.patch

	sed -i -e "s:gcc:$(tc-getCC):" Makefile || die "sed failed."
}

src_compile() {
	make LIBS='' VERSION="$PV" realpath || die
}

src_install() {
	dobin realpath || die
	doman man/realpath.1
	dodoc README TODO BUGS
}
