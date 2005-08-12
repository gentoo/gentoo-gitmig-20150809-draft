# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/longrun/longrun-0.9-r1.ebuild,v 1.12 2005/08/12 19:12:56 betelgeuse Exp $

inherit eutils

DESCRIPTION="A utility to control Transmeta's Crusoe processor"
HOMEPAGE="http://freshmeat.net/projects/longrun/"
GCC3_PATCH="${P}-debian-gcc-3.diff.gz"
SRC_URI="mirror://kernel/linux/utils/cpu/crusoe/${P}.tar.bz2
		 mirror://gentoo/${GCC3_PATCH}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${GCC3_PATCH}
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin longrun || die "dosbin failed"
	doman longrun.1
	dodoc MAKEDEV-cpuid-msr
}
