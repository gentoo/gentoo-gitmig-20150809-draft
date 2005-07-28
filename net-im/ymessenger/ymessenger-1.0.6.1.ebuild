# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ymessenger/ymessenger-1.0.6.1.ebuild,v 1.2 2005/07/28 18:46:10 sekretarz Exp $

inherit rpm eutils

IUSE=""

MY_P=${PN}-${PV%.*}-${PV#*.*.*.*}
S=${WORKDIR}
DESCRIPTION="Yahoo's instant messenger client"
HOMEPAGE="http://public.yahoo.com/~mmk/index.html"
SRC_URI="http://public.yahoo.com/~mmk/rh9.${MY_P}.i386.rpm"

RDEPEND="virtual/x11
	media-libs/gdk-pixbuf
	dev-libs/openssl"

SLOT="0"
LICENSE="yahoo"
KEYWORDS="-* ~x86"

src_install () {
	cd ${S}/opt/ymessenger/bin

	exeinto /opt/ymessenger/bin
	doexe ymessenger.bin ymessenger

	insinto /usr/share/icons/hicolor/48x48/apps
	newins yahoo_gnome.png yahoo.png

	sed -e 's:Icon=.*:Icon=yahoo:' -i ymessenger.desktop
	domenu ymessenger.desktop

	into /opt/ymessenger
	dolib ${S}/opt/ymessenger/lib/libgtkhtml.so.0

	echo >${T}/ymessenger.gentoo <<EOF
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
