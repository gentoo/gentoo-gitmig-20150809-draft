#Copyright 2002 Gentoo Technologies, Inc.
#Distributed under the terms of the GNU General Public License, v2 or later
#$Header: /var/cvsroot/gentoo-x86/sys-apps/s3switch/s3switch-19990826.ebuild,v 1.2 2002/07/14 19:20:19 aliz Exp $

DESCRIPTION="S3 video chipset output selection utility"
HOMEPAGE="http://www.probo.com/timr/savage40.html"
KEYWORDS="x86"
SLOT="0"
LICENSE=""

SRC_URI="http://www.probo.com/timr/s3ssrc.zip"
A=s3ssrc.zip
S=${WORKDIR}

RDEPEND="virtual/glibc"
DEPEND="$RDEPEND"

src_compile() {
	make || die
}

src_install () {
	dobin s3switch
	doman s3switch.1x
}



