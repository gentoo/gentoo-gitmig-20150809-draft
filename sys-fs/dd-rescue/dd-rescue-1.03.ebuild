# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dd-rescue/dd-rescue-1.03.ebuild,v 1.4 2004/06/30 17:07:11 vapier Exp $

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

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README.dd_rescue
}
