# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxclient/nxclient-2.1.0.ebuild,v 1.2 2006/12/14 15:13:33 beu Exp $

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using
remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="http://www.nomachine.com/"
SRC_URI="http://64.34.161.181/download/2.1.0/Linux/nxclient-2.1.0-9.i386.tar.gz"
LICENSE="nomachine"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nostrip"

DEPEND=""
RDEPEND="
	dev-libs/expat
	dev-libs/openssl
	media-libs/audiofile
	media-libs/jpeg
	media-libs/libpng
	media-libs/freetype
	media-libs/fontconfig
	net-analyzer/gnu-netcat
	net-print/cups
	x11-libs/libXft
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXrender
	x11-libs/libXau
	x11-libs/libXext
	=x11-libs/qt-3*
	sys-libs/lib-compat"

S=${WORKDIR}/NX

src_install()
{
	cd ${S}

	# we install nxclient into /usr/NX, to make sure it doesn't clash
	# with libraries installed for FreeNX

	for x in nxclient nxesd nxkill nxprint nxservice nxssh ; do
		into /usr/NX
		dobin bin/$x || die
		into /usr
		newbin ${FILESDIR}/nxwrapper $x || die
	done

	into /usr/NX
	dolib lib/libXcompsh.so*
	dolib lib/libXcomp.so*

	dodir /usr/NX/share
	cp -R share ${D}/usr/NX
}
