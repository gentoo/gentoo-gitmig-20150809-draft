# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsplusutils/hfsplusutils-1.0.4-r1.ebuild,v 1.4 2004/02/06 18:10:50 vapier Exp $

inherit eutils

MY_P="hfsplus_${PV}"
DESCRIPTION="HFS+ Filesystem Access Utilities (a PPC filesystem)"
HOMEPAGE="http://ftp.penguinppc.org/users/hasi/"
SRC_URI="http://ftp.penguinppc.org/users/hasi/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64"

DEPEND="sys-devel/autoconf
	sys-devel/automake
	app-arch/bzip2"
RDEPEND=""

S=${WORKDIR}/hfsplus-${PV}

MAKEOPTS='PREFIX=/usr MANDIR=/usr/share/man'

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/hfsplusutils-1.0.4-glob.patch
	epatch ${FILESDIR}/hfsplusutils-1.0.4-errno.patch
}

src_compile() {
	# This does a autoconf, automake, etc.
	export WANT_AUTOCONF=2.5
	emake -f Makefile.cvs all || die
	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	newman doc/man/hfsp.man hfsp.1
}
