# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-0.60.2.ebuild,v 1.13 2004/02/04 00:07:15 solar Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utilities for rescue and embedded systems"
SRC_URI="ftp://oss.lineo.com/busybox/${P}.tar.gz"
HOMEPAGE="http://www.busybox.net"
KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/Config.h-${PV}-cd ${S}/Config.h
	#This is an old patch from the mailing list that it looks like they forgot
	#to apply.  References:
	#http://www.google.com/search?q=cache:biJRjMW2U3g:opensource.lineo.com/lists/busybox/2001-July/004023.html+%22bad+identifier%22+busybox&hl=en
	#This patch has already been applied to their CVS, so it doesn't need to
	#be reported.
	cd ${S}
	patch -p0 < ${FILESDIR}/msh.diff || die
}

src_compile() {
	emake || die
}

src_install() {
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
