# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-4.04-r2.ebuild,v 1.5 2004/07/15 03:38:18 agriffis Exp $

inherit eutils

IUSE="static"
DESCRIPTION="TLS/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"
HOMEPAGE="http://stunnel.mirt.net"
DEPEND="virtual/libc >=dev-libs/openssl-0.9.6j"
RDEPEND=">=dev-libs/openssl-0.9.6j"
KEYWORDS="~x86 ~sparc ~alpha"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	use static && myconf="${myconf} --disable-shared --enable-static"
	use static && LDADD="${LDADD} -all-static" && export LDADD
	econf ${myconf} || die
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

	exeinto /etc/init.d
	newexe ${FILESDIR}/stunnel.rc6.${PF} stunnel

	dolib src/.libs/libstunnel.la
	use static || newlib.so src/.libs/libstunnel.so libstunnel.so.${PV}
	use static || dosym /usr/lib/libstunnel.so.${PV} /usr/lib/libstunnel.so

	insinto /etc/stunnel
	donewins ${FILESDIR}/stunnel.conf.${PF} stunnel.conf

	dosed "s:/usr/etc/stunnel:/etc/stunnel:" /etc/stunnel/stunnel.conf

	dodir /etc/stunnel

}

pkg_postinst() {
	enewuser stunnel
	enewgroup stunnel

	einfo "Starting from version 4 stunnel now uses a configuration file for setting up stunnels."
	einfo "Stunnel can now also be run as a daemon"
}
