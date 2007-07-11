# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sguil-client/sguil-client-0.6.1.ebuild,v 1.4 2007/07/11 23:49:24 mr_bones_ Exp $

inherit eutils

MY_PV="${PV/_p/p}"
DESCRIPTION="GUI Console for sguil Network Security Monitoring"
HOMEPAGE="http://sguil.sf.net"
SRC_URI="mirror://sourceforge/sguil/sguil-client-${MY_PV}.tar.gz"
LICENSE="QPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND=""
RDEPEND="
	>=dev-lang/tcl-8.3
	>=dev-lang/tk-8.3
	>=dev-tcltk/itcl-3.2
	>=dev-tcltk/tclx-8.3
	dev-tcltk/itk
	dev-tcltk/iwidgets
	dev-tcltk/tcllib
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	net-analyzer/wireshark"

S="${WORKDIR}/sguil-${MY_PV}"

pkg_setup() {
	if built_with_use dev-lang/tcl threads ; then
		eerror
		eerror "Sguil does not run when tcl was built with threading enabled."
		eerror "Please rebuild tcl without threads and reemerge this ebuild."
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e '/^set SGUILLIB /s:./lib:/usr/lib/sguil:' \
		-e '/^set ETHEREAL_PATH /s:/usr/sbin/ethereal:/usr/bin/wireshark:' \
		-e '/^set SERVERHOST /s:demo.sguil.net:localhost:' \
		-e '/^set MAILSERVER /s:mail.example.com:localhost:' \
		client/sguil.conf || die "sed failed"
	sed -i -e 's:^exec wish:exec wishx': \
		client/sguil.tk || die "sed failed"
}

src_install() {
	dobin client/sguil.tk
	insinto /etc/sguil
	doins client/sguil.conf
	mkdir -p "${D}/usr/lib/sguil"
	cp -a ${S}/client/lib/* "${D}/usr/lib/sguil/"
	dodoc doc/*
}

pkg_postinst() {
	elog
	elog "You can customize your configuration by modifying /etc/sguil/sguil.conf"
	elog
}
