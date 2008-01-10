# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/arm-fdisk/arm-fdisk-3.0.6.ebuild,v 1.2 2008/01/10 17:39:54 jer Exp $

inherit eutils

DEB_VER=6
DESCRIPTION="edit disk partitions on Acorn machines"
HOMEPAGE="http://www.arm.linux.org.uk/"
SRC_URI="ftp://ftp.arm.linux.org.uk/pub/armlinux/source/other/${P}.tar.gz
	mirror://debian/pool/main/a/acorn-fdisk/acorn-fdisk_${PV}-${DEB_VER}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/acorn-fdisk_${PV}-${DEB_VER}.diff
	sed -i \
		-e "s:-O2 -Wall -g:${CFLAGS}:" \
		-e "s:-O2 -Wall -I.. -g:${CFLAGS} -I..:" \
		-e '/^STRIP/s:strip:true:' \
		$(find . -name Makefile)
}

src_install() {
	into /
	newsbin fdisk ${PN} || die "sbin failed"
	dosym ${PN} /sbin/acorn-fdisk
	dodoc ChangeLog README debian/changelog
}
