# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/tribler/tribler-5.9.19.ebuild,v 1.1 2012/07/03 21:19:02 blueness Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit eutils python

MY_PV="${PN}_${PV}-1ubuntu1_all"

DESCRIPTION="Bittorrent client that does not require a website to discover content"
HOMEPAGE="http://www.tribler.org/"
SRC_URI="http://dl.tribler.org/${MY_PV}.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vlc"

RDEPEND="
	>=dev-python/apsw-3.6
	>=dev-python/m2crypto-0.16
	dev-python/netifaces
	>=dev-libs/openssl-0.9.8
	>=dev-python/wxpython-2.8
	vlc? ( >=media-video/vlc-1.1.0 )"

# Skipping for now:
# xulrunner-sdk >= 1.9.1.5 < 1.9.2 (optional, to run SwarmTransport)
# 7-Zip >= 4.6.5 (optional, to build SwarmTransport)

DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-5.9.12-fix-global-declarations.patch"
	epatch "${FILESDIR}/${PN}-log2homedir.patch"

	python_convert_shebangs -r 2 .
}

src_compile() { :; }

src_install() {
	#Rename the doc dir properly
	mv usr/share/doc/${PN} usr/share/doc/${P}

	#Move the readme to the doc dir
	mv usr/share/${PN}/Tribler/readme.txt usr/share/doc/${P}

	#Remove the licenses scattered throughout
	rm usr/share/doc/${P}/copyright
	rm usr/share/${PN}/Tribler/*.txt
	rm usr/share/${PN}/Tribler/Core/DecentralizedTracking/pymdht/{LGPL-2.1.txt,LICENSE.txt}

	#Copy the rest over
	cp -pPR usr/ "${ED}"/
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"usr/share/${PN}
}
