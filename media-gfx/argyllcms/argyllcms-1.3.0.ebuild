# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/argyllcms/argyllcms-1.3.0.ebuild,v 1.6 2011/02/26 17:06:55 signals Exp $

MY_P="Argyll_V${PV}"
DESCRIPTION="Open source, ICC compatible color management system"
HOMEPAGE="http://www.argyllcms.com/"
SRC_URI="http://www.argyllcms.com/${MY_P}_src.zip"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

RDEPEND="media-libs/tiff
	virtual/jpeg
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/ftjam"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# Make it respect LDFLAGS
	echo "LINKFLAGS += ${LDFLAGS} ;" >> Jamtop

	# Evil hack to get --as-needed working. The build system unfortunately lists all
	# the shared libraries by default on the command line _before_ the object to be built...
	echo "STDLIBS += -ldl -lrt -lX11 -lXext -lXxf86vm -lXinerama -lXrandr -lXau -lXdmcp -lXss -ltiff ;" >> Jamtop

	local jobnumber=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[[:space:]]*[0-9]\+\).*/\1/; p }")
	[ ${jobnumber} ] || jobnumber=-j1

	jam -q -fJambase ${jobnumber} || die
}

src_install() {
	jam -q -fJambase install || die

	rm bin/License.txt || die
	dobin bin/* || die

	if use doc; then
		dohtml doc/* || die
	fi

	dodoc log.txt Readme.txt ttbd.txt notes.txt || die

	insinto /usr/share/${PN}/ref
	doins   ref/*  || die

	insinto /etc/udev/rules.d
	doins libusb/55-Argyll.rules || die
}

pkg_postinst() {
	elog
	elog "If you have a Spyder2 you need to extract the firmware"
	elog "from the spyder2_setup.exe (ColorVision CD)"
	elog "and store it as /usr/bin/spyd2PLD.bin"
	elog
	elog "For further info on setting up instrument access read"
	elog "http://www.argyllcms.com/doc/Installing_Linux.html"
	elog
}
