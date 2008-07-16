# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-otr/irssi-otr-0.2.ebuild,v 1.1 2008/07/16 14:10:55 armin76 Exp $

inherit cmake-utils eutils

DESCRIPTION="Off-The-Record messaging (OTR) for irssi"
HOMEPAGE="http://irssi-otr.tuxfamily.org"

# This should probably be exported by cmake-utils as a variable
CMAKE_BINARY_DIR="${WORKDIR}"/${PN}_build
mycmakeargs="-DDOCDIR=/usr/share/doc/${PF}"

SRC_URI="ftp://download.tuxfamily.org/irssiotr/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="net-libs/libotr
	net-irc/irssi"

DEPEND="${RDEPEND}
	dev-libs/glib
	>=dev-util/cmake-2.4.7
	dev-util/pkgconfig
	dev-lang/python"

src_install() {
	cmake-utils_src_install
	rm "${D}"/usr/share/doc/${PF}/LICENSE
	prepalldocs
}
