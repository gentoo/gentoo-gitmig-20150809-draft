# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.15.ebuild,v 1.4 2004/06/11 13:52:16 kugelfang Exp $

inherit eutils 64-bit

DESCRIPTION="Asynchronous input/output library maintained by RedHat, required by Oracle9i AMD64 edition"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/${P}-2.5-2.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls"

DEPEND=""

S="${WORKDIR}/${P}-2.5-2"

src_compile() {
	cd ${S}
	#this is a -fPIC patch, used on 64bit only
	64-bit && epatch ${FILESDIR}/${P}-2.5-2-Makefile.patch
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die
}
