# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsplusutils/hfsplusutils-1.0.4.ebuild,v 1.5 2005/02/16 09:59:37 lu_zero Exp $

MY_P="hfsplus_${PV}"
DESCRIPTION="HFS+ Filesystem Access Utilities"
HOMEPAGE="http://ftp.penguinppc.org/users/hasi/"
SRC_URI="http://ftp.penguinppc.org/users/hasi/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""

DEPEND="sys-devel/autoconf
	sys-devel/automake
	app-arch/bzip2"
RDEPEND=""

S=${WORKDIR}/hfsplus-${PV}

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_compile() {
	# This does a autoconf, automake, etc.
	emake -f Makefile.cvs all || die

	patch -p0 < ${FILESDIR}/hfsplusutils-1.0.4-glob.patch || die "Patch failed"

	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	newman doc/man/hfsp.man hfsp.1
}
