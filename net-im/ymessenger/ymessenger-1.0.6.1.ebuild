# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-1.0.6.1.ebuild,v 1.6 2006/10/30 05:16:55 tester Exp $

inherit rpm eutils

IUSE=""

MY_P=${PN}-${PV%.*}-${PV#*.*.*.*}
S=${WORKDIR}
DESCRIPTION="Yahoo's instant messenger client"
HOMEPAGE="http://public.yahoo.com/~mmk/index.html"
SRC_URI="http://public.yahoo.com/~mmk/rh9.${MY_P}.i386.rpm"

RDEPEND="x86?  ( dev-libs/openssl
		media-libs/gdk-pixbuf
		=x11-libs/gtk+-1.2*
		x11-libs/libXi
		x11-libs/libXmu )
	amd64? ( app-emulation/emul-linux-x86-xlibs
			>=app-emulation/emul-linux-x86-gtklibs-2.2 )"

SLOT="0"
LICENSE="yahoo"
KEYWORDS="-* ~amd64 ~x86"

src_install () {
	cd ${S}/opt/ymessenger/bin

	exeinto /opt/ymessenger/bin
	doexe ymessenger.bin ymessenger

	insinto /usr/share/icons/hicolor/48x48/apps
	newins yahoo_gnome.png yahoo.png

	sed -e 's:Icon=.*:Icon=yahoo:' -i ymessenger.desktop
	domenu ymessenger.desktop

	exeinto /opt/ymessenger/lib
	doexe ${S}/opt/ymessenger/lib/libgtkhtml.so.0

	cat >${T}/ymessenger.gentoo <<EOF
#!/bin/sh
LD_LIBRARY_PATH=/opt/ymessenger/lib:\$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
exec /opt/ymessenger/bin/ymessenger.bin $@
EOF

	exeinto /usr/bin
	newexe ${T}/ymessenger.gentoo ymessenger
}

pkg_postinst() {
	einfo ""
	einfo "If you are upgrading from an older version of ymessenger,"
	einfo "please unmerge the previous version."
	einfo "-=AND=-"
	einfo "mv ~/.ymessenger/preferences ~/.ymessenger/preferences.old"
	einfo ""
}
