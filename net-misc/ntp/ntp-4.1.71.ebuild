# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Terry Chan <tchan@enteract.com>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.71.ebuild,v 1.1 2001/10/05 23:13:51 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz"
HOMEPAGE="http://www.ntp.org/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1"

src_compile() {
	cp configure configure.orig
	sed -e "s:-Wpointer-arith::" configure.orig > configure
	LDFLAGS="$LDFLAGS -lncurses"

	./configure --prefix=/usr --mandir=/usr/share/man \
		--host=${CHOST} --build=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	docinto html ; dodoc html/*.htm
	docinto html/hints ; dodoc html/hints/*
	docinto html/pic ; dodoc html/pic/*

	insinto /usr/share/ntp
	doins scripts/*
}
