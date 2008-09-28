# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/coccinella/coccinella-0.96.10.ebuild,v 1.1 2008/09/28 17:07:06 bass Exp $

NAME=Coccinella
DESCRIPTION="Jabber Client With a Built-in Whiteboard and VoIP (jingle)"
HOMEPAGE="http://www.thecoccinella.org/"
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Src.tar.gz"

inherit eutils

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/tk-8.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}-${PV}Src"

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/coccinella
	cp -R "${S}"/* ${D}/opt/coccinella/
	fperms 0755 /opt/coccinella/Coccinella.tcl
	dosym /opt/coccinella/Coccinella.tcl /opt/bin/coccinella
	dodoc CHANGES README.txt READMEs/*
	
	for x in 64 32 16 ; do
		src=/opt/coccinella/themes/Crystal/icons/${x}x${x}/coccinella.png
		dir=/usr/share/icons/hicolor/${x}x${x}/apps
		dodir ${dir}
		dosym ${src} ${dir}/coccinella.png
		unset src
		unset dir
	done
	
	make_desktop_entry "coccinella" "Coccinella IM Client"
}

pkg_postinst() {
	elog "To run coccinella just type \"coccinella\""
}
