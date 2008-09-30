# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sunstudioexpress/sunstudioexpress-2008.07.24.ebuild,v 1.1 2008/09/30 12:08:07 flameeyes Exp $

inherit versionator

MY_PN="StudioExpress"
MY_TAG="-ii"
MY_PV="$(replace_all_version_separators -)"
MY_P="${MY_PN}-linux-x86-${MY_PV}${MY_TAG}"

DESCRIPTION="Sun Studio Express Compilers for Linux"
HOMEPAGE="http://developers.sun.com/sunstudio/downloads/express/index.jsp"
RESTRICT="fetch"
SRC_URI="${MY_P}.sh"

LICENSE="SunStudioExpress LGPL-2 BSD as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs )
	sys-libs/zlib"
DEPEND=""
S="${WORKDIR}"

pkg_nofetch() {
	einfo "Go to ${HOMEPAGE}"
	einfo "and download ${SRC_URI}"
}

src_unpack() {
	# Since the unpack script is broken, do it manually
	# It would be nice to find the magic number automatically..
	tail -n +651 "${DISTDIR}"/${A} | bzip2 -d | tar -oxf -
}

src_install() {
	DIR="/opt/SunStudioExpress"

	dodir /opt
	cp -r sunstudioceres "${D}"${DIR}

	# Set SUNW_NO_UPDATE_NOTIFY to anything but false to disable
	# writes to /root/.sunstudio
	# These writes break the sandbox when building anything with Sun
	# compilers
	cat << EOF >> "${T}"/envd
ROOTPATH="${DIR}/bin"
PATH="${DIR}/bin"
MANPATH="${DIR}/man"
SUNW_NO_UPDATE_NOTIFY="true"
EOF

	newenvd "${T}"/envd 05${PN}
}
