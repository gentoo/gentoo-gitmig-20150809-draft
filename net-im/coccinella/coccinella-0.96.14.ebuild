# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/coccinella/coccinella-0.96.14.ebuild,v 1.1 2009/11/24 11:15:41 bass Exp $

inherit eutils fdo-mime

NAME=Coccinella
DESCRIPTION="Jabber Client With a Built-in Whiteboard and VoIP (jingle)"
HOMEPAGE="http://www.thecoccinella.org/"
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/tk-8.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}-${PV}Src"

src_unpack() {
	unpack ${A}
}

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/coccinella
	cp -R "${S}"/* ${D}/opt/coccinella/
	fperms 0755 /opt/coccinella/Coccinella.tcl
	dosym /opt/coccinella/Coccinella.tcl /opt/bin/coccinella
	# dosym /usr/lib/tkpng0.9/libtkpng0.9.so /opt/coccinella/bin/unix/Linux/i686/tkpng/libtkpng0.9.so
	# dosym /usr/lib/treectrl2.2.9/libtreectrl2.2.so /opt/coccinella/bin/unix/Linux/i686/treectrl/libtreectrl2.2.so
	dodoc README.txt READMEs/*

	for x in 128 64 32 16 ; do
		src=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella.png
		src2=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella.png
		src2shadow=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella2-shadow.png
		dir=/usr/share/icons/hicolor/${x}x${x}/apps
		dodir ${dir}
		dosym ${src} ${dir}/coccinella.png
		dosym ${src2} ${dir}/coccinella2.png
		dosym ${src2shadow} ${dir}/coccinella2-shadow.png
		unset src
		unset src2
		unset src2shadow
		unset dir
	done

	make_desktop_entry "coccinella" "Coccinella IM Client" "coccinella2-shadow.png" "Network" "/usr/share/icons/hicolor/128x128/apps/coccinella2-shadow.png"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
