# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/afio/afio-2.4.7.ebuild,v 1.7 2002/08/14 07:42:55 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="makes cpio-format archives and deals somewhat gracefully with input data corruption."
SRC_URI="http://www.ibiblio.org/pub/linux/system/backup/${P}.tgz"
HOMEPAGE="http://freshmeat.net/projects/afio/"

SLOT="0"
LICENSE="Artistic|LGPL-2"
KEYWORDS="x86 ppc"

DEPEND="sys-apps/gzip"

src_compile() {
	emake || die
}

src_install () {
	cd ${S}
	dobin afio
	dodoc README SCRIPTS HISTORY INSTALLATION PORTING
	for i in 1 2 3 4 5 ; do
		insinto /usr/share/doc/${P}/script$i
		doins script$i/*
	done
	#prepalldocs
	doman afio.1
}
