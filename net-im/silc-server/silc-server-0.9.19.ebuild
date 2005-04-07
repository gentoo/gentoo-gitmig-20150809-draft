# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/silc-server-0.9.19.ebuild,v 1.1 2005/04/07 13:37:22 ticho Exp $

inherit eutils

MY_P="${P}p1"
DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/server/sources/${MY_P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="ipv6 debug"

DEPEND="!<=net-im/silc-toolkit-0.9.12-r1
	!<=net-im/silc-client-1.0.1"

src_compile() {
	local toolkit_conf=""
	has_version '>=net-im/silc-toolkit-0.9.13' && { \
		toolkit_conf="${toolkit_conf} --with-silc-libs=/usr$(get_libdir) --with-silc-includes=/usr/include/silc-toolkit"
		toolkit_conf="${toolkit_conf} --with-simdir=/usr/lib/silc-toolkit"
	} || \
		toolkit_conf="${toolkit_conf} --with-simdir=/usr/lib/${PN}"

	econf ${toolkit_conf} \
		--sysconfdir=/etc/silc \
		--with-docdir=/usr/share/doc/${PF} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-logsdir=/var/log/${PN} \
		--with-mandir=/usr/share/man \
		--with-silcd-pid-file=/var/run/silcd.pid \
		`use_enable ipv6` \
		`use_enable debug` \
		|| die "econf failed"
	emake -j1 all || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.conf

	fperms 600 /etc/${PN}
	keepdir /var/log/${PN}

	rm -rf \
		${D}/usr/libsilc* \
		${D}/usr/include \
		${D}/etc/silc/silcd.{pub,prv}

	exeinto /etc/init.d
	newexe ${FILESDIR}/silcd.rc6 silcd

	sed -i \
		-e 's:10.2.1.6:0.0.0.0:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		-e 's:${D}::g' \
		${D}/etc/silc/silcd.conf
}

pkg_postinst() {
	enewuser silcd

	if [ ! -f ${ROOT}/etc/${PN}/silcd.prv ] ; then
		einfo "Creating key pair in ${ROOT}etc/silc"
		silcd -C ${ROOT}etc/silc
	fi

	echo
	ewarn "Configuration and server keys have been moved to /etc/silc, please check"
	ewarn "your files."
	echo
	ewarn "Initscript name has changed from silc-server to silcd in this version."
	echo
}
