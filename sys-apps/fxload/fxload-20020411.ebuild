# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fxload/fxload-20020411.ebuild,v 1.14 2004/06/30 02:27:54 vapier Exp $

# source maintainers named it fxload-YYYY_MM_DD instead of fxload-YYYYMMDD
MY_P="${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}"
DESCRIPTION="USB firmware uploader"
HOMEPAGE="http://linux-hotplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~hppa amd64"
IUSE=""

DEPEND="virtual/libc
	sys-apps/hotplug"

S=${WORKDIR}/${MY_P}

src_compile() {
	make || die
}

src_install() {
	make install prefix=${D} || die
}
