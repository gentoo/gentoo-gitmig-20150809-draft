# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsplusutils/hfsplusutils-1.0.4-r1.ebuild,v 1.8 2005/02/16 09:59:37 lu_zero Exp $

inherit eutils libtool

MY_P="hfsplus_${PV}"
DESCRIPTION="HFS+ Filesystem Access Utilities (a PPC filesystem)"
HOMEPAGE="http://ftp.penguinppc.org/users/hasi/"
SRC_URI="http://ftp.penguinppc.org/users/hasi/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64"
IUSE=""

DEPEND="sys-devel/autoconf
	sys-devel/automake
	app-arch/bzip2"
RDEPEND="virtual/libc"

S=${WORKDIR}/hfsplus-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/hfsplusutils-1.0.4-glob.patch
	epatch ${FILESDIR}/hfsplusutils-1.0.4-errno.patch
	#let's avoid the Makefile.cvs since isn't working for us
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6
	aclocal
	autoconf
	autoheader
	automake -a
	libtoolize --force --copy
	elibtoolize
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man
	make \
		prefix=${D}/usr \
		libdir=${D}/usr/lib \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	newman doc/man/hfsp.man hfsp.1
}
