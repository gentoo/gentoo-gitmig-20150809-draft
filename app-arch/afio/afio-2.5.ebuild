# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/afio/afio-2.5.ebuild,v 1.1 2004/02/25 21:36:40 mr_bones_ Exp $

DESCRIPTION="makes cpio-format archives and deals somewhat gracefully with input data corruption."
HOMEPAGE="http://freshmeat.net/projects/afio/"
SRC_URI="http://members.brabant.chello.nl/~k.holtman/${P}.tgz"

LICENSE="Artistic LGPL-2"
KEYWORDS="x86 ppc sparc"
SLOT="0"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	#our cflags
	sed -i \
		-e "s:-O2 -fomit-frame-pointer:${CFLAGS}:" Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	local i

	dobin afio                                || die "dobin failed"
	dodoc ANNOUNCE-2.5 HISTORY README SCRIPTS || die "dodoc failed"
	for i in 1 2 3 4 5 ; do
		insinto /usr/share/doc/${P}/script$i
		doins script$i/*                      || die "doins failed (${i})"
	done
	doman afio.1                              || die "doman failed"
}
