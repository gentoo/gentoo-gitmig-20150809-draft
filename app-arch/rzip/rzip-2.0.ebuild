# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rzip/rzip-2.0.ebuild,v 1.2 2004/04/11 20:38:35 dholm Exp $

IUSE=""

DESCRIPTION="rzip is a compression program for large files"
SRC_URI="http://rzip.samba.org/ftp/rzip/${P}.tar.gz"
HOMEPAGE="http://rzip.samba.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	sys-apps/coreutils
	app-arch/bzip2"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc COPYING
}
