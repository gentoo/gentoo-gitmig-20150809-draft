# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/s3switch/s3switch-19990826.ebuild,v 1.13 2004/07/15 02:32:27 agriffis Exp $

DESCRIPTION="S3 video chipset output selection utility"
HOMEPAGE="http://www.probo.com/timr/savage40.html"
KEYWORDS="x86 amd64 -ppc"
IUSE=""
SLOT="0"
LICENSE="as-is"

SRC_URI="http://www.probo.com/timr/s3ssrc.zip"
S=${WORKDIR}

DEPEND="virtual/libc
	app-arch/unzip"

src_compile() {
	make || die
}

src_install() {
	dobin s3switch
	doman s3switch.1x
}
