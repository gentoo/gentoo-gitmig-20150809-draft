# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.15.ebuild,v 1.3 2004/04/21 16:40:32 vapier Exp $

inherit eutils

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
	epatch ${FILESDIR}/${P}-2.5-2-Makefile.patch
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die
}
