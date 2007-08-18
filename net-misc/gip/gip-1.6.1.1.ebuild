# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gip/gip-1.6.1.1.ebuild,v 1.4 2007/08/18 15:18:16 malc Exp $

inherit versionator distutils

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="A nice GNOME GUI for making IP address based calculations"
HOMEPAGE="http://www.debain.org/software/gip/"
SRC_URI="http://dl.debain.org/gip/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

IUSE=""
DEPEND=">=dev-cpp/gtkmm-2.4
	>=dev-libs/glib-2.2.3
	>=dev-libs/libsigc++-2.0"

S="${WORKDIR}/${MY_P}"

src_compile() {
	sed -i -e 's@INST_PIXMAPDIR=\"$INST_PREFIX/lib/$EXECUTABLE\"@INST_PIXMAPDIR=\"/usr/lib/$EXECUTABLE\"@g' build.sh
	# Crazy build system...
	./build.sh --prefix "${D}/usr" || die "./build failed"
}

src_install() {
	dodoc AUTHORS CHANGELOG README
	sed -i -e 's@INST_PIXMAPDIR=\"/usr/lib/$EXECUTABLE\"@INST_PIXMAPDIR=\"$INST_PREFIX/lib/$EXECUTABLE\"@g' build.sh
	# Crazy build system...
	./build.sh --install --prefix "${D}/usr" || die "./build --install failed"
	make_desktop_entry gip "GIP IP Address Calculator" gnome-calc3.png Network
}
