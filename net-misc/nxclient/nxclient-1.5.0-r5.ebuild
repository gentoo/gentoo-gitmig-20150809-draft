# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxclient/nxclient-1.5.0-r5.ebuild,v 1.2 2007/03/21 19:39:39 armin76 Exp $

inherit rpm

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="http://www.nomachine.com"

IUSE=""
LICENSE="nomachine"
SLOT="0"
RESTRICT="nostrip"
SRC_URI="http://web04.nomachine.com/download/1.5.0/client/${P}-141.i386.rpm"

# This is only supported upstream on 32-bit x86.
# Do _not_ mark it for any other arches.
KEYWORDS="x86"

DEPEND="
	net-analyzer/gnu-netcat
	amd64? (
		app-emulation/emul-linux-x86-compat
		>=app-emulation/emul-linux-x86-baselibs-2.1.4
		>=app-emulation/emul-linux-x86-xlibs-2.2.1
		>=app-emulation/emul-linux-x86-qtlibs-2.1.1
	)
	x86? (
		>=dev-libs/expat-1.95.7
		>=media-libs/fontconfig-2.2.2
		>=media-libs/freetype-2.1.9
		=x11-libs/qt-3*
		sys-libs/lib-compat
	)"

RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	rpm_src_unpack
}

src_install()
{
	# we install nxclient into /usr/NX ;
	# this location is reserved for NoMachine's binary releases only
	cp -dPR usr ${D}

	# install a wrapper script for nxclient
	newbin ${FILESDIR}/nxwrapper nxclient

	# FIXME: Of the options in the applnk directory, the desktop files in the
	# "network" directory seem to make the most sense.  I have no idea if this
	# works for KDE or just for Gnome.
	declare applnk=/usr/NX/share/applnk apps=/usr/share/applications
	if [[ -d ${D}${applnk} ]]; then
		dodir ${apps}
		mv ${D}${applnk}/network/*.desktop ${D}${apps}
		rm ${D}${apps}/nxclient-help.desktop
		rm -rf ${D}${applnk}
	fi
}
