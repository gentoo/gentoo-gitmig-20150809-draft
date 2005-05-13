# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvssl/dvssl-0.5.4.ebuild,v 1.6 2005/05/13 01:35:40 pvdabeel Exp $

S=${WORKDIR}/dvssl-${PV}
DESCRIPTION="dvssl provides a simple interface to openssl"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/download/dvssl-${PV}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvssl/html/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

IUSE=""
DEPEND="virtual/libc
	dev-libs/openssl
	dev-libs/dvutil
	dev-libs/dvnet"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/0.5.4-gentoo-doc_distdir.patch || die "patching failed"
}

src_install() {
	make DESTDIR=${D} install || die "error in make install"
}
