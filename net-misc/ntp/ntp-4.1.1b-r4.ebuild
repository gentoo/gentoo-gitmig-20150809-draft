# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.1b-r4.ebuild,v 1.4 2003/02/15 19:52:43 dragon Exp $

inherit eutils

DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz"
HOMEPAGE="http://www.ntp.org/"

LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha mips"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/ntp-bk.diff
	epatch ${FILESDIR}/linux-config-phone.patch
	use alpha && epatch ${FILESDIR}/ntp-4.1.1b-syscall-libc.patch
	aclocal -I . || die
	automake || die
	autoconf || die
}

src_compile() {
	cp configure configure.orig
	sed -e "s:-Wpointer-arith::" configure.orig > configure

	econf --build=${CHOST} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	dohtml -r html/*

	insinto /usr/share/ntp
	doins scripts/* ${FILESDIR}/ntp.conf

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntpd.rc ntpd
	insinto /etc/conf.d ; newins ${FILESDIR}/ntpd.confd ntpd
}

pkg_postinst() {
	ewarn "You can find /etc/ntp.conf in /usr/share/ntp/"
	ewarn "Please run etc-update and then read all the comments"
	ewarn "all the comments in /etc/ntp.conf and"
	ewarn "/etc/conf.d/ntpd"
}
