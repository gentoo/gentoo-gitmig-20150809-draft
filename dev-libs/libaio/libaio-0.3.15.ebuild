# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.15.ebuild,v 1.2 2004/03/14 12:28:57 mr_bones_ Exp $

DESCRIPTION="Asynchronous input/output library maintained by RedHat, required by Oracle9i AMD64 edition"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/${P}-2.5-2.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

DEPEND=""

S="${S}-2.5-2"

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${P}-2.5-2-Makefile.patch
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die
}
