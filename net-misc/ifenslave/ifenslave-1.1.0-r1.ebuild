# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ifenslave/ifenslave-1.1.0-r1.ebuild,v 1.2 2005/02/22 10:58:46 blubb Exp $

inherit gcc eutils

DESCRIPTION="Attach and detach slave interfaces to a bonding device"
HOMEPAGE="http://sf.net/projects/bonding/"
MY_PN="ifenslave-2.6" # this is NOT an error
DEBIAN_PV="3"
DEBIANPKG_TARBALL="${MY_PN}_${PV}.orig.tar.gz"
DEBIANPKG_PATCH="${MY_PN}_${PV}-${DEBIAN_PV}.diff.gz"
DEBIANPKG_BASE="mirror://debian/pool/main/${MY_PN:0:1}/${MY_PN}"
SRC_URI="${DEBIANPKG_BASE}/${DEBIANPKG_TARBALL}
		 ${DEBIANPKG_BASE}/${DEBIANPKG_PATCH}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
RDEPEND="sys-libs/glibc"
DEPEND="sys-devel/gcc
		|| ( >=sys-kernel/linux-headers-2.4.22
			 sys-kernel/linux26-headers )
		${RDEPEND}"

src_unpack() {
	unpack ${DEBIANPKG_TARBALL}
	EPATCH_OPTS="-d ${S} -p1" epatch ${DISTDIR}/${DEBIANPKG_PATCH}
}

src_compile() {
	$(gcc-getCC) ${CFLAGS} ${PN}.c -o ${PN} || die "Failed to compile!"
}

src_install() {
	doman ${S}/${PN}.8
	into /
	dosbin ${PN}
	# there really is no better documentation than the sourcecode :-)
	dodoc ${PN}.c
	insinto /etc/modules.d
	newins ${FILESDIR}/modules.d-bond bond
}

pkg_postinst() {
	einfo "If you want to use bonding on your system, be sure to use"
	einfo "baselayout-1.10, where support is now integrated!"
}
