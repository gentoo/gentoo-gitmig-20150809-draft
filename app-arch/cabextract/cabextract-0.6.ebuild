# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cabextract/cabextract-0.6.ebuild,v 1.11 2003/12/17 05:00:43 brad_mssw Exp $

DESCRIPTION="Extracts files from Microsoft .cab files"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"
HOMEPAGE="http://www.kyz.uklinux.net/cabextract.php3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha arm hppa mips amd64 ia64 ppc64"

DEPEND="virtual/glibc"

src_compile() {
	econf
	emake || die
}

src_install() {
	dobin cabextract
	doman cabextract.1
	dodoc COPYING NEWS README TODO AUTHORS
}
