# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxclient/nxclient-1.5.0-r2.ebuild,v 1.4 2006/08/23 12:45:51 caleb Exp $

inherit rpm

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="http://www.nomachine.com"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="-alpha ~amd64 -mips -ppc -sparc ~x86"
RESTRICT="nostrip"

SRC_URI="http://web04.nomachine.com/download/1.5.0/client/$P-135.i386.rpm"

DEPEND="
	=net-misc/nxssh-1.5*
	net-analyzer/gnu-netcat
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-2.1.4
	)
	x86? (
		media-libs/jpeg
		sys-libs/glibc
		sys-libs/zlib
		dev-libs/expat
		media-libs/fontconfig
		media-libs/freetype
		media-libs/jpeg
		media-libs/libpng
		net-print/cups
		=x11-libs/qt-3*
		sys-libs/lib-compat
		|| ( (	x11-libs/libX11
				x11-libs/libXext
			)
			virtual/x11
		)
	)"

S=${WORKDIR}

src_install() {
	# rpm has usr/NX/; tarball has only NX/
	if [[ ! -d usr ]]; then
		mkdir usr
		mv NX usr || die
	fi

	cp -dPR usr ${D}

	# All of the libraries delivered by nxclient are available in our deps.
	# Additionally a couple of the binaries are better installed as deps.
	# Remove those now...

	# delivered by net-misc/nxcomp
	rm -f ${D}/usr/NX/lib/libXcomp.so*

	# delivered by net-misc/nx-x11 (at some point)
	rm -f ${D}/usr/NX/bin/nxesd

	# delivered by net-misc/nxssh
	rm -f ${D}/usr/NX/bin/nxssh

	# delivered by other deps (emul-linux-x86-baselibs on amd64)
	rm -f ${D}/usr/NX/lib/lib{crypto,jpeg,png,z}*

	# make sure there are no libs left (this is to catch problems when this
	# package is updated)
	rmdir ${D}/usr/NX/lib || die "leftover libraries in ${D}/usr/NX/lib"

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

	# Install env.d snippet to add /usr/NX/bin to the PATH
	insinto /etc/env.d
	doins ${FILESDIR}/1.5.0/50nxclient
}
