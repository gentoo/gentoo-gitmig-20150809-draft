# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/frox/frox-0.7.17.ebuild,v 1.1 2005/01/24 14:05:34 dragonheart Exp $

inherit eutils

IUSE="clamav"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A transparent ftp proxy"
SRC_URI="http://frox.sourceforge.net/download/${MY_P}.tar.bz2"
HOMEPAGE="http://frox.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

DEPEND="clamav? ( >=app-antivirus/clamav-0.80 )"


pkg_setup() {
	enewgroup ftpproxy
	enewuser ftpproxy -1 /bin/false /var/spool/frox ftpproxy
}

src_compile() {

	econf \
		--sbindir=/usr/sbin \
		--localstatedir=/var/run \
		--sysconfdir=/etc \
		--enable-http-cache --enable-local-cache \
		`use_enable clamav virus-scan` || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	keepdir /var/run/frox
	keepdir /var/spool/frox
	fperms 700 /var/spool/frox
	fowners ftpproxy:ftpproxy /var/run/frox /var/spool/frox

	dodoc BUGS COPYING README \
		doc/CREDITS doc/ChangeLog doc/FAQ doc/INSTALL \
		doc/INTERNALS doc/README.transdata doc/RELEASE \
		doc/SECURITY doc/TODO

	dohtml doc/*.html doc/*.sgml

	mv doc/frox.man doc/frox.man.8
	mv doc/frox.conf.man doc/frox.conf.man.8
	doman doc/frox.man.8 doc/frox.conf.man.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/frox.rc frox

	sed -e "s:^# User.*:User ftpproxy:" -e "s:^# Group.*:Group ftpproxy:" \
		./src/frox.conf > ${D}/etc/frox.conf.example

}
