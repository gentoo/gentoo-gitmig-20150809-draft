# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-boot-bin/systemimager-boot-bin-3.0.1.ebuild,v 1.1 2003/10/17 12:04:36 bass Exp $

MY_P="systemimager-i386boot-standard-3.0.1-4.noarch"

S=${WORKDIR}
DESCRIPTION="System imager boot-i386. Software that automates Linux installs, software distribution, and production deployment."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-arch/rpm2targz"
RDPEND="${DEPEND}
		app-admin/systemimager-server-bin"

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm
	tar zxf ${WORKDIR}/${MY_P}.tar.gz
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {

#stuff in /usr
	mkdir -p ${D}/usr/share/systemimager/boot/i386/standard
	insinto /usr/share/systemimager/boot/i386/standard
	doins usr/share/systemimager/boot/i386/standard/*
}

