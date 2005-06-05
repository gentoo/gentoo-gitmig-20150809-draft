# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/lcap/lcap-0.0.6-r1.ebuild,v 1.10 2005/06/05 11:27:10 hansmi Exp $

inherit eutils

DESCRIPTION="kernel capability remover"
# Real homepage seems to be dead http://pweb.netcom.com/~spoon/lcap/
HOMEPAGE="http://packages.debian.org/stable/admin/lcap.html"
SRC_URI="mirror://debian/pool/main/l/lcap/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="lids"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}.patch
	use lids || sed -i -e "s:LIDS =:#\0:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dosbin lcap || die
	doman lcap.8
	dodoc README ${FILESDIR}/README.gentoo
}
