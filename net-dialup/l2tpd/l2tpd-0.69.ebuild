# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/l2tpd/l2tpd-0.69.ebuild,v 1.2 2004/02/11 20:18:44 lanius Exp $

DESCRIPTION="Layer 2 Tunnelling Protocol Daemon"
HOMEPAGE="http://www.l2tpd.org/"
SRC_URI="http://www.l2tpd.org/downloads/${P}.tar.gz
	mirror://gentoo/${PN}-${PV}-gcc-3.3.patch.gz"
#	http://www.jacco2.dds.nl/networking/freeswanl2tpconfig-1.1.tgz"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	epatch ${DISTDIR}/${PN}-${PV}-gcc-3.3.patch.gz

	#compile optimized
	cp Makefile Makefile.orig
	sed -e "s|-g -O2|${CFLAGS}|" Makefile.orig >Makefile
		#-e "s|^#\(OSFLAGS+= -DUSE_KERNEL\)|\1|" \
		#^wants an #include <linux/l2tp>

	#make sure these stay just like so
	cp file.h file.h.orig
	sed -e 's|\(#define DEFAULT_AUTH_FILE \).*|\1"/etc/l2tpd/l2tp-secrets"|' \
	    -e 's|\(#define DEFAULT_CONFIG_FILE \).*|\1"/etc/l2tpd/l2tpd.conf"|' \
	    -e 's|\(#define DEFAULT_PID_FILE \).*|\1"/var/run/l2tpd.pid"|' \
	    file.h.orig >file.h
}

src_compile() {
	emake || die
}

src_install() {
	dosbin l2tpd
	doman doc/*.[85]

	dodoc BUGS CHANGELOG LICENSE CREDITS README TODO \
		doc/rfc2661.txt doc/*.sample
	#cp -a ../freeswanl2tpconfig ${D}/usr/share/doc/${PF}
	#chown -R root.root ${D}/usr/share/doc/${PF}
	#mv ${D}/usr/share/doc/${PF}/freeswanl2tpconfig \
	#	${D}/usr/share/doc/${PF}/samples

	insinto /etc/l2tpd
	newins doc/l2tp-secrets.sample l2tp-secrets
	newins doc/l2tpd.conf.sample l2tpd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/l2tpd-init l2tpd
}
