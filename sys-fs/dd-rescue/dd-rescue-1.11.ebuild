# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rescue/dd-rescue-1.11.ebuild,v 1.1 2005/08/12 03:44:05 vapier Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
DESCRIPTION="similar to dd but can copy from source with errors"
HOMEPAGE="http://www.garloff.de/kurt/linux/ddrescue/"
SRC_URI="http://www.garloff.de/kurt/linux/ddrescue/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="static"

RDEPEND=""
DEPEND=""

S=${WORKDIR}/${MY_PN}

src_compile() {
	use static && append-flags -static
	emake RPM_OPT_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README.dd_rescue
}
