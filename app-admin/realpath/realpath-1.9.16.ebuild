# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/realpath/realpath-1.9.16.ebuild,v 1.7 2005/04/08 10:24:45 corsair Exp $

DESCRIPTION="Return the canonicalized absolute pathname"
HOMEPAGE="http://packages.debian.org/unstable/utils/realpath.html"
SRC_URI="mirror://debian/pool/main/d/dwww/dwww_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips amd64 ppc64 ppc-macos ~hppa"
IUSE=""

S=${WORKDIR}/dwww-${PV}

src_unpack() {
	if use ppc-macos; then
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
}

src_compile() {
	make LIBS='' VERSION=$PV realpath || die
}

src_install() {
	dobin realpath || die
	doman man/realpath.1
	dodoc README TODO BUGS
}
