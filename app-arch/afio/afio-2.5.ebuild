# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/afio/afio-2.5.ebuild,v 1.7 2005/01/01 11:40:20 eradicator Exp $

inherit eutils

DESCRIPTION="makes cpio-format archives and deals somewhat gracefully with input data corruption."
HOMEPAGE="http://freshmeat.net/projects/afio/"
SRC_URI="http://members.brabant.chello.nl/~k.holtman/${P}.tgz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64 ~alpha"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.patch
	# use our cflags
	sed -i \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" \
		Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	local i
	dobin afio || die "dobin failed"
	dodoc ANNOUNCE-2.5 HISTORY README SCRIPTS
	for i in 1 2 3 4 5 ; do
		docinto script$i
		dodoc script$i/*
	done
	doman afio.1
}
