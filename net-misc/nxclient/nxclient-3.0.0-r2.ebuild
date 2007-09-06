# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxclient/nxclient-3.0.0-r2.ebuild,v 1.3 2007/09/06 17:15:24 voyageur Exp $

inherit eutils

MY_PV="${PV}-73"
DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="amd64? ( http://64.34.161.181/download/${PV}/Linux/nxclient-${MY_PV}.x86_64.tar.gz )
	x86? ( http://64.34.161.181/download/${PV}/Linux/nxclient-${MY_PV}.i386.tar.gz )"
LICENSE="nomachine"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="dev-libs/expat
	dev-libs/openssl
	media-libs/audiofile
	media-libs/jpeg
	media-libs/libpng
	media-libs/freetype
	media-libs/fontconfig
	net-print/cups
	x11-libs/libXft
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXrender
	x11-libs/libXau
	x11-libs/libXext
	sys-libs/zlib
	!net-misc/nxclient-2xterminalserver"

S=${WORKDIR}/NX

src_install()
{
	# we install nxclient into /usr/NX, to make sure it doesn't clash
	# with libraries installed for FreeNX

	for x in nxclient nxesd nxkill nxprint nxservice nxssh ; do
		into /usr/NX
		dobin bin/$x
		into /usr
		make_wrapper $x ./$x /usr/NX/bin /usr/NX/lib || die
	done

	dodir /usr/NX/lib
	cp -P lib/libXcompsh.so* lib/libXcomp.so* ${D}/usr/NX/lib

	dodir /usr/NX/share
	cp -R share ${D}/usr/NX

	# Add icons/desktop entries (missing in the tarball)
	cd share/icons
	for size in *; do
		dodir /usr/share/icons/hicolor/${size}/apps
		for icon in admin desktop icon wizard; do
			dosym /usr/NX/share/icons/${size}/nxclient-${icon}.png \
				/usr/share/icons/hicolor/${size}/apps
			done
		done
	make_desktop_entry "nxclient" "NX Client" nxclient-icon
	make_desktop_entry "nxclient -admin" "NX Session Administrator" nxclient-admin
	make_desktop_entry "nxclient -wizard" "NX Connection Wizard" nxclient-wizard
}
