# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/longrun/longrun-0.9.ebuild,v 1.6 2002/07/29 05:14:19 cselkirk Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A utility to control Transmeta's Crusoe processor"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/cpu/crusoe/${P}.tar.bz2"
HOMEPAGE="http://freshmeat.net/projects/longrun/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die
}

src_install() {
	dosbin longrun

	doman longrun.1

	dodoc COPYING MAKEDEV-cpuid-msr
}
