# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mdadm/mdadm-1.6.0.ebuild,v 1.1 2004/06/09 00:50:35 swtaylor Exp $

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools, or as a supplement."
HOMEPAGE="http://www.cse.unsw.edu.au/~neilb/source"
SRC_URI="http://www.cse.unsw.edu.au/~neilb/source/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha"
IUSE="static"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use static ; then
		sed -i \
			-e "44s:^# ::" \
			-e "45s:^# ::" Makefile \
				|| die "sed Makefile failed"
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
