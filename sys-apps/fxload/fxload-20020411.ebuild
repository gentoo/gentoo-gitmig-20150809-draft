# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fxload/fxload-20020411.ebuild,v 1.17 2007/01/24 10:23:38 zzam Exp $

inherit eutils

# source maintainers named it fxload-YYYY_MM_DD instead of fxload-YYYYMMDD
MY_P="${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}"
DESCRIPTION="USB firmware uploader"
HOMEPAGE="http://linux-hotplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86 ia64"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	if has_version ">=sys-kernel/linux-headers-2.6.19"; then
		epatch ${FILESDIR}/${P}-linux-headers-2.6.19.patch
	fi
}

src_compile() {
	make RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	make install prefix=${D} || die
}
