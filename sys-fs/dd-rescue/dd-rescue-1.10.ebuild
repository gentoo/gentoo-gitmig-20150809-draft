# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rescue/dd-rescue-1.10.ebuild,v 1.1 2004/09/04 03:02:09 swegener Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_PN}
DESCRIPTION="similar to dd but can copy from source with errors"
HOMEPAGE="http://www.garloff.de/kurt/linux/ddrescue/"
SRC_URI="http://www.garloff.de/kurt/linux/ddrescue/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

RDEPEND=""
DEPEND=">=sys-apps/sed-4"

src_compile() {
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README.dd_rescue || die "dodoc failed"
}
