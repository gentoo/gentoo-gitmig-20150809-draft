# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mdadm/mdadm-1.7.0.ebuild,v 1.3 2004/11/25 14:21:03 gmsoft Exp $

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools, or as a supplement."
HOMEPAGE="http://cgi.cse.unsw.edu.au/~neilb/mdadm"
SRC_URI="mirror://kernel/utils/raid/mdadm/${P}.tgz
	http://neilb.web.cse.unsw.edu.au/source/mdadm/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~alpha ~amd64 hppa"
IUSE="static"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use static ; then
		sed -i \
			-e "44s:^# ::" \
			-e "45s:^# ::" \
			Makefile || die "sed Makefile failed"
	fi
}

src_compile() {
	emake CXFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc INSTALL TODO "ANNOUNCE-${PV}"

	insinto /etc
	newins mdadm.conf-example mdadm.conf
}
