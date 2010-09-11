# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ksymoops/ksymoops-2.4.11-r1.ebuild,v 1.1 2010/09/11 19:54:52 robbat2 Exp $

inherit eutils

DESCRIPTION="Utility to decode a kernel oops, or other kernel call traces"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/ksymoops/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-fortify-fix.patch
}

src_install() {
	dobin ksymoops || die
	doman ksymoops.8
	dodoc Changelog README README.XFree86
}
