# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-4.02.ebuild,v 1.2 2002/12/09 04:33:19 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="TSL/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"
HOMEPAGE="http://stunnel.mirt.net"
DEPEND="virtual/glibc >=dev-libs/openssl-0.9.6c"
RDEPEND=">=dev-libs/openssl-0.9.6c"
KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}; cd ${S}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	into /usr
	dosbin src/stunnel
	dodoc AUTHORS BUGS COPYING COPYRIGHT.GPL CREDITS INSTALL NEWS PORTS README TODO
	dodoc doc/en/transproxy.txt
	dohtml doc/stunnel.html doc/en/VNC_StunnelHOWTO.html tools/ca.html tools/importCA.html
	doman doc/stunnel.8

	insinto /usr/share/doc/${PF}
	doins tools/ca.pl tools/importCA.sh

	insinto /etc/init.d
	newins ${FILESDIR}/stunnel.rc6 stunnel

	dolib src/.libs/libstunnel.la
	dolib.so src/.libs/libstunnel.so

	insinto /etc
	doins ${FILESDIR}/stunnel.conf	
}

pkg_postinst() {
	einfo "Starting from version 4 stunnel now uses a configuration file for setting up stunnels."
	einfo "Stunnel can now also be run as a daemon"
}
