# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/silc-server-0.9.18.ebuild,v 1.3 2005/04/07 13:37:22 ticho Exp $

inherit eutils

DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/server/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6 debug"

DEPEND="!<=net-im/silc-toolkit-0.9.12-r1
	!<=net-im/silc-client-1.0.1"

src_compile() {
	econf \
		--sysconfdir=/etc/${PN} \
		--with-docdir=/usr/share/doc/${PF} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-logsdir=/var/log/${PN} \
		--with-simdir=/usr/lib/${PN} \
		--with-mandir=/usr/share/man \
		`use_enable ipv6` \
		`use_enable debug` \
		|| die "econf failed"
	emake -j1 all || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	fperms 600 /etc/${PN}
	keepdir /var/log/${PN}

	rm -rf \
		${D}/usr/libsilc* \
		${D}/usr/include \
		${D}/etc/${PN}/silcd.{pub,prv}

	exeinto /etc/init.d
	newexe ${FILESDIR}/silc-server.rc6 silc-server

	sed -i \
		-e 's:/var/lib/silcd.pid:/var/run/silcd.pid:' \
		-e 's:ip = "10.2.1.6";:ip = "0.0.0.0";:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		${D}/etc/${PN}/silcd.conf
}

pkg_postinst() {
	enewuser silcd

	if [ ! -f ${ROOT}/etc/${PN}/silcd.prv ] ; then
		einfo "Creating key pair in ${ROOT}/etc/${PN}"
		silcd -C ${ROOT}/etc/${PN}
	fi
}
