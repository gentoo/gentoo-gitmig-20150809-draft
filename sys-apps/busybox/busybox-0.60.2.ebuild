# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-0.60.2.ebuild,v 1.1 2001/12/19 15:22:32 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="ftp://oss.lineo.com/busybox/${P}.tar.gz"
HOMEPAGE="http://busybox.lineo.com/"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Config.h-${PV}-cd ${S}/Config.h
}

src_compile() {
	emake || die
}

src_install () {
	into /    
	dobin busybox
	into /usr
	dodoc AUTHORS Changelog LICENSE README TODO
	cd docs
	doman *.1
	docinto txt
	dodoc *.txt
	docinto sgml
	dodoc *.sgml
	docinto pod
	dodoc *.pod

	cd busybox.lineo.com
	docinto html
	dodoc *.html
	docinto html/images
	dodoc images/*
}

