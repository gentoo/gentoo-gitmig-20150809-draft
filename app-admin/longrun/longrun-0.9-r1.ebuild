# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/longrun/longrun-0.9-r1.ebuild,v 1.9 2004/06/25 17:55:13 vapier Exp $

inherit eutils

DESCRIPTION="A utility to control Transmeta's Crusoe processor"
HOMEPAGE="http://freshmeat.net/projects/longrun/"
SRC_URI="mirror://kernel/linux/utils/cpu/crusoe/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-debian-gcc-3.diff
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin longrun || die "dosbin failed"
	doman longrun.1
	dodoc MAKEDEV-cpuid-msr
}
