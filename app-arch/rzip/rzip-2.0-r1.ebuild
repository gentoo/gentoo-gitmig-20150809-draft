# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rzip/rzip-2.0-r1.ebuild,v 1.3 2004/07/18 05:36:04 ferringb Exp $

DESCRIPTION="compression program for large files"
HOMEPAGE="http://rzip.samba.org/"
SRC_URI="http://rzip.samba.org/ftp/rzip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc amd64 ppc64"
IUSE=""

DEPEND="virtual/libc
	sys-apps/coreutils
	app-arch/bzip2"

src_install() {
	einstall || die
	dosym /usr/bin/rzip /usr/bin/runzip
}
