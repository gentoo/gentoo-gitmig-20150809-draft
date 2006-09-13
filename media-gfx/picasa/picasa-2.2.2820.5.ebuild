# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picasa/picasa-2.2.2820.5.ebuild,v 1.6 2006/09/13 00:16:40 genstef Exp $

inherit eutils versionator

MY_P="picasa-$(replace_version_separator 3 '-')"
DESCRIPTION="Google's photo organizer"
HOMEPAGE="http://picasa.google.com"
SRC_URI="http://dl.google.com/linux/standalone/${MY_P}.i386.bin"
LICENSE="google-picasa LGPL-2 GPL-2 MPL-1.1 BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="mirror strip"
QA_TEXTRELS_x86="opt/picasa/wine/lib/wine/license.exe.so"
QA_EXECSTACK_x86="opt/picasa/bin/xsu
               opt/picasa/wine/bin/wine
               opt/picasa/wine/bin/wineserver
               opt/picasa/wine/bin/wine-pthread
               opt/picasa/wine/bin/wine-kthread
               opt/picasa/wine/lib/*
               opt/picasa/wine/lib/wine/*"

RDEPEND="dev-libs/atk
	dev-libs/glib
	dev-libs/libxml2
	sys-libs/zlib
	x11-libs/gtk+
	|| (
		(
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXt
		)
		virtual/x11
	)
	x11-libs/pango"
S=${WORKDIR}

src_unpack() {
	unpack_makeself

	sed -i -e "s:28.20:28.3205:" \
		'wine/drive_c/Program Files/Picasa2/update/LifeScapeUpdater/currentversion.ini'
	sed -i -e "s:;;HKLM,Soft:HKLM,Soft:" -e \
		's:"DisableMediaDetector",0x10003,0x00000001:"DisableMediaDetector",0x10003,0x00000000:' \
		wine/drive_c/windows/inf/picasa.inf

	# Display unicode filenames correctly by not unsetting locale, bug #147094
	epatch ${FILESDIR}/picasa-unicode.patch
}

src_install() {
	insinto /opt/picasa
	doins -r bin wine
	chmod a+x ${D}/opt/picasa/{wine/{lib/{wine/*.so,*.so.1},bin/*},bin/*}
	keepdir /opt/picasa/wine/drive_c/windows/{command,system}

	dodir /usr/bin
	for i in picasa mediadetector s{et,how}picasascreensaver; do
		dosym /opt/picasa/bin/${i} /usr/bin/${i}
	done

	dodoc README LICENSE.FOSS

	cd desktop
	mv google-picasa-mediadetector.desktop.template google-picasa-mediadetector.desktop
	mv google-picasa.desktop.template google-picasa.desktop
	sed -i -e "s:EXEC:mediadetector:" google-picasa-mediadetector.desktop
	sed -i -e "s:EXEC:picasa:" google-picasa.desktop
	sed -i -e "s:ICON:picasa.xpm:" google-picasa{,-mediadetector}.desktop

	doicon picasa.xpm
	domenu {google-picasa{,-mediadetector},picasascr}.desktop
}
