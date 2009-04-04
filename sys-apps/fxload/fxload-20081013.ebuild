# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fxload/fxload-20081013.ebuild,v 1.1 2009/04/04 08:52:38 bangert Exp $

EAPI="2"

inherit eutils

# source maintainers named it fxload-YYYY_MM_DD instead of fxload-YYYYMMDD
MY_P="${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}"
DESCRIPTION="USB firmware uploader"
HOMEPAGE="http://linux-hotplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" || die
}

src_install() {
	emake prefix="${D}" install || die
	dodoc README.txt
}
