# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/silc-server-0.9.21.ebuild,v 1.1 2005/05/07 17:56:54 swegener Exp $

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
		--sysconfdir=/etc/silc \
		--with-docdir=/usr/share/doc/${PF} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-logsdir=/var/log/${PN} \
		--with-mandir=/usr/share/man \
		--with-silcd-pid-file=/var/run/silcd.pid \
		--with-simdir=/usr/$(get_libdir)/${PN} \
		--without-silc-libs \
		$(use_enable ipv6) \
		$(use_enable debug) \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.conf

	fperms 600 /etc/silc
	keepdir /var/log/${PN}

	rm -rf \
		${D}/usr/libsilc* \
		${D}/usr/include \
		${D}/etc/silc/silcd.{pub,prv}

	newinitd ${FILESDIR}/silcd.rc6 silcd

	sed -i \
		-e 's:10.2.1.6:0.0.0.0:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		-e 's:${D}::g' \
		${D}/etc/silc/silcd.conf
}

pkg_postinst() {
	enewuser silcd

	if [ ! -f ${ROOT}/etc/silc/silcd.prv ] ; then
		einfo "Creating key pair in /etc/silc"
		silcd -C ${ROOT}/etc/silc
	fi

	ewarn
	ewarn "Configuration and server keys have been moved to /etc/silc, please check"
	ewarn "your files."
	ewarn
	ewarn "Initscript name has changed from silc-server to silcd in this version."
	ewarn
}
