# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unarj/unarj-2.63a-r2.ebuild,v 1.10 2005/02/06 18:21:29 corsair Exp $

inherit eutils

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="http://ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

LICENSE="arj"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc sparc x86 ppc64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/^CFLAGS/s:-O2:${CFLAGS}:" ${S}/Makefile
	epatch ${FILESDIR}/unarj-2.65-CAN-2004-0947.patch
	epatch ${FILESDIR}/unarj-2.65-sanitation.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin unarj || die
	dodoc unarj.txt technote.txt readme.txt
}
