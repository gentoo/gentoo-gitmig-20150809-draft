# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.1b.ebuild,v 1.5 2002/12/16 16:17:35 vapier Exp $

DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz"
HOMEPAGE="http://www.ntp.org/"

LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A} && cd ${S}
	patch -p1 < ${FILESDIR}/ntp-bk.diff
	aclocal -I . || die
	automake || die
	autoconf || die
}

src_compile() {
	cp configure configure.orig
	sed -e "s:-Wpointer-arith::" configure.orig > configure

	econf --build=${CHOST}
	emake || die
}

src_install() {
	einstall

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	insinto /usr/share/doc/${PF}/html ; doins html/*.htm
	insinto /usr/share/doc/${PF}/html/hints ; doins html/hints/*
	insinto /usr/share/doc/${PF}/html/pic ; doins html/pic/*

	insinto /usr/share/ntp ; doins scripts/*

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntpd.rc ntpd
	insinto /etc ; newins ${FILESDIR}/ntp.conf ntp.conf
}
