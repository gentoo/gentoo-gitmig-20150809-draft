# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linesrv/linesrv-2.1.20.ebuild,v 1.1 2004/12/05 15:56:10 mrness Exp $

inherit eutils

# if someone disables pam but wants user authentication
# to be supported, then crypt is needed.
IUSE="pam mysql crypt"

DESCRIPTION="Client/Server system to control the Internet link of a masquerading server"
HOMEPAGE="http://linecontrol.srf.ch/"

S=${WORKDIR}/${PN}-2.1
SRC_URI="http://linecontrol.srf.ch/down/${P}.src.tar.bz2"

# requesting glibc instead of virtual/libc
# because we might need crypt. And as far as I
# (S. Fuchs, author of linesrv) remember, there's
# glibc specific stuff in linesrv.
DEPEND=">=sys-libs/glibc-2.2.0
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-4 )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

[ -z "$HTTPD_ROOT" ] && HTTPD_ROOT=/var/www/localhost

src_compile() {
	local myauth mymysql
	# sfuchs: configure script of linesrv 2 is quite bad...
	# prefer pam, if disabled try crypt
	# the configure script will disable authentication if
	# neither pam nor crypt is available.
	if ! ( use pam ); then
		myauth="--disable-pamauth"
		if use crypt; then
			myauth="--enable-cryptauth"
		fi
	fi
	# --enable-mysql is not supported... stupid, I know.
	use mysql || mymysql="--disable-mysql"
	econf ${myauth} ${mymysql} || die "bad configure"
	emake || die
}

src_install() {
	dodir /usr/share/linesrv /var/log/linesrv ${HTTPD_ROOT}/htdocs/lclog

	dosbin server/linesrv

	exeinto ${HTTPD_ROOT}/cgi-bin ; doexe lclog/lclog htmlstatus/htmlstatus
	chmod 4755 ${D}${HTTPD_ROOT}/cgi-bin/htmlstatus
	insinto ${HTTPD_ROOT}/htdocs/lclog ; doins lclog/html/*

	mknod ${D}/usr/share/linesrv/logpipe p
	exeinto /usr/share/linesrv ; doexe server/config/complete_syntax/halt-wrapper

	dodoc server/{INSTALL,NEWS,README}
	newdoc htmlstatus/README README.htmlstatus
	newdoc lclog/INSTALL INSTALL.lclog
	docinto complete_syntax ; dodoc server/config/complete_syntax/*

	exeinto /etc/init.d ; newexe ${FILESDIR}/linesrv.rc6 linesrv
	insinto /etc ; newins ${FILESDIR}/linesrv.conf linesrv.conf.sample
	insinto /etc/pam.d ; newins ${FILESDIR}/linecontrol.pam linecontrol
	insinto /etc/pam.d ; newins ${FILESDIR}/lcshutdown.pam lcshutdown
}
