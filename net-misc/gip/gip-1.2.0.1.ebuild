# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gip/gip-1.2.0.1.ebuild,v 1.2 2005/09/03 20:55:24 vanquirius Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="A nice GNOME GUI for making IP address based calculations"
HOMEPAGE="http://www.debain.org/software/gip/"
SRC_URI="http://web222.mis02.de/releases/gip/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="=dev-cpp/gtkmm-2.2*
	>=dev-libs/glib-2.2.3
	=dev-libs/libsigc++-1.2*"

S="${WORKDIR}/${MY_P}"

src_compile() {
	./build.sh --prefix ${D}/usr || die "./build failed"
}

src_install() {
	dodoc AUTHORS CHANGELOG INSTALL README
	./build.sh --install --prefix ${D}/usr || die "./build --install failed"
}
