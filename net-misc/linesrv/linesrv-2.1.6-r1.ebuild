# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/linesrv/linesrv-2.1.6-r1.ebuild,v 1.4 2002/08/14 12:08:08 murphy Exp $

DESCRIPTION="Client/Server system to control the Internet link of a masquerading server"
HOMEPAGE="http://linecontrol.sourceforge.net"

S=${WORKDIR}/linesrv-2.1
SRC_URI="mirror://sourceforge/linecontrol/${PN}-${PV}.src.tar.bz2"
#windows client: http://people.ee.ethz.ch/~sfuchs/LineControl/down/wlc-122.zip

DEPEND="virtual/glibc pam? ( >=sys-libs/pam-0.75 )"
RDEPEND="virtual/glibc net-www/apache"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

[ -z "$HTTPD_ROOT" ] && HTTPD_ROOT=/home/httpd

src_unpack() {
	unpack ${PN}-${PV}.src.tar.bz2
}

src_compile() {
	local myconf
	use pam || myconf="--disable-pamauth"

	./configure \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--host=${CHOST} ${myconf} || die "bad configure"

	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /usr/share/linesrv /var/log/linesrv ${HTTPD_ROOT}/htdocs/lclog

	dosbin server/linesrv

	exeinto ${HTTPD_ROOT}/cgi-bin ; doexe lclog/lclog htmlstatus/htmlstatus
	chmod 4755 ${HTTPD_ROOT}/cgi-bin/htmlstatus
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
