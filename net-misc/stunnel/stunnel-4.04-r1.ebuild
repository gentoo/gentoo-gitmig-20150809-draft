# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stunnel/stunnel-4.04-r1.ebuild,v 1.1 2003/06/25 10:25:38 aliz Exp $

inherit eutils

IUSE="static"
S=${WORKDIR}/${P}
DESCRIPTION="TLS/SSL - Port Wrapper"
SRC_URI="http://www.stunnel.org/download/stunnel/src/${P}.tar.gz"
HOMEPAGE="http://stunnel.mirt.net"
DEPEND="virtual/glibc >=dev-libs/openssl-0.9.6c"
RDEPEND=">=dev-libs/openssl-0.9.6c"
KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
	epatch ${FILESDIR}/${P}-blinding.patch
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
	newexe ${FILESDIR}/stunnel.rc6 stunnel

	dolib src/.libs/libstunnel.la
	use static || newlib.so src/.libs/libstunnel.so libstunnel.so.${PV}
	use static || dosym /usr/lib/libstunnel.so.${PV} /usr/lib/libstunnel.so

	insinto /etc/stunnel
	doins ${FILESDIR}/stunnel.conf	

	dosed "s:/usr/etc/stunnel:/etc/stunnel:" /etc/stunnel/stunnel.conf

	dodir /etc/stunnel
}

pkg_postinst() {
	einfo "Starting from version 4 stunnel now uses a configuration file for setting up stunnels."
	einfo "Stunnel can now also be run as a daemon"
}
