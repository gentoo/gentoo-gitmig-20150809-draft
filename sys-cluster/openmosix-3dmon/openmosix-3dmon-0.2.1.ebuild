# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosix-3dmon/openmosix-3dmon-0.2.1.ebuild,v 1.1 2004/03/21 19:44:52 tantive Exp $

S=${WORKDIR}/3dmon-${PV}
DESCRIPTION="Three dimensional monitoring tool for openmosix cluster"
SRC_URI="mirror://sourceforge/threedmosmon/3dmon-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/threedmosmon"
DEPEND="virtual/glibc
	virtual/opengl"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"

src_unpack() {
	unpack ${A}

	cd ${S}											&& \
		epatch ${FILESDIR}/${P}-trivial.patch.bz2	|| die "Failed to patch the source."
}

src_compile() {
	cd ${S}/3dmosmon
	make
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/doc

	cd ${S}/3dmosmon
	chmod 0755 3dmosmon && cp -f ./3dmosmon ${D}/usr/bin

	cd ${S}
	dodoc COPYING README AUTHORS ChangeLog TODO
}

pkg_postinst() {
	einfo
	einfo "Don't forget to run statistics daemon (openmosix-3dmon-stats)"
	einfo "on one of yours openMosix's nodes."
	einfo
}
