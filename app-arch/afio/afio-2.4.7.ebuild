# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/afio/afio-2.4.7.ebuild,v 1.16 2003/11/14 21:22:37 seemant Exp $

inherit eutils

DESCRIPTION="makes cpio-format archives and deals somewhat gracefully with input data corruption."
SRC_URI="http://www.ibiblio.org/pub/linux/system/backup/${P}.tgz"
HOMEPAGE="http://freshmeat.net/projects/afio/"

SLOT="0"
LICENSE="Artistic LGPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="app-arch/gzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.patch
}

src_compile() {
	emake CFLAGS1="${CFLAGS}" || die "emake failed"
}

src_install() {
	local i

	dobin afio                                || die "dobin failed"
	dodoc README SCRIPTS HISTORY INSTALLATION || die "dodoc failed"
	for i in 1 2 3 4 5 ; do
		insinto /usr/share/doc/${P}/script$i
		doins script$i/*                      || die "doins failed (${i})"
	done
	doman afio.1                              || die "doman failed"
}
