# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/ntp/ntp-4.1.1a.ebuild,v 1.5 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Network Time Protocol suite/programs"
SRC_URI="http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/${P}.tar.gz"
HOMEPAGE="http://www.ntp.org/"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1"
RDEPEND="${DEPEND}"

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
#	If there is a reason why we need -lncurses in LDFLAGS, please
#	read the ChangeLog and contact me, jnelson@gentoo.org
#	LDFLAGS="$LDFLAGS -L/lib -lncurses"

	./configure --prefix=/usr --mandir=/usr/share/man \
	--host=${CHOST} --build=${CHOST} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die

	dodoc ChangeLog INSTALL NEWS README TODO WHERE-TO-START
	insinto /usr/share/doc/${PF}/html ; doins html/*.htm
	insinto /usr/share/doc/${PF}/html/hints ; doins html/hints/*
	insinto /usr/share/doc/${PF}/html/pic ; doins html/pic/*

	insinto /usr/share/ntp ; doins scripts/*

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntpd.rc6 ntpd
	insinto /etc/conf.d ; newins ${FILESDIR}/ntpd.confd ntpd
}
