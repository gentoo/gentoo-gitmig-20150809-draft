# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.1b-r6.ebuild,v 1.2 2003/06/26 14:45:57 vapier Exp $

inherit eutils

DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz
	mirror://gentoo/${PF}-manpages.tbz2"
HOMEPAGE="http://www.ntp.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc mips alpha arm hppa"
IUSE="parse-clocks"

DEPEND=">=sys-apps/sed-4.0.5
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
	cp configure{,.orig}
	sed -i "s:-Wpointer-arith::" configure

	econf \
		--build=${CHOST} \
		`use_enable parse-clocks` \
		|| die
	emake || die
}

src_install() {
	einstall || die

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	doman ${WORKDIR}/man/*.1
	dohtml -r html/*

	insinto /usr/share/ntp
	doins ${FILESDIR}/ntp.conf
	rm -rf `find scripts/ \
		-name '*.in' -o \
		-name 'Makefile*' -o \
		-name 'rc[12]' -o \
		-name support`
	mv scripts/* ${D}/usr/share/ntp/

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntpd.rc ntpd
	insinto /etc/conf.d ; newins ${FILESDIR}/ntpd.confd ntpd
}

pkg_postinst() {
	ewarn "You can find an example /etc/ntp.conf in /usr/share/ntp/"
	ewarn "Review /etc/ntp.conf to setup server info."
	ewarn "Review /etc/conf.d/ntpd to setup init.d info."
}
