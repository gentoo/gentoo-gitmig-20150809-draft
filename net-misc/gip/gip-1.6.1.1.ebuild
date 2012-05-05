# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gip/gip-1.6.1.1.ebuild,v 1.13 2012/05/05 03:20:45 jdhore Exp $

EAPI=3
inherit eutils versionator

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="A nice GNOME GUI for making IP address based calculations"
HOMEPAGE="http://www.debain.org/software/gip/"
SRC_URI="http://dl.debain.org/gip/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	dev-libs/glib:2
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-libsigcpp.patch" \
		"${FILESDIR}"/${P}-asneeded.patch
	sed -i -e "s:g++:$(tc-getCXX):" installer/build_files.sh
	sed -i -e 's@INST_PIXMAPDIR=\"$INST_PREFIX/lib/$EXECUTABLE\"@INST_PIXMAPDIR=\"/usr/lib/$EXECUTABLE\"@g' build.sh
	sed -i -e 's@INST_PIXMAPDIR=\"/usr/lib/$EXECUTABLE\"@INST_PIXMAPDIR=\"$INST_PREFIX/lib/$EXECUTABLE\"@g' build.sh
	sed -i -e 's@INST_DOCDIR=\"$INST_PREFIX/doc/$EXECUTABLE\"@INST_DOCDIR=\"$INST_PREFIX/share/doc/'${PF}'\"@g' build.sh
}

src_compile() {
	# Crazy build system...
	./build.sh --prefix "${D}/usr" || die "./build failed"
}

src_install() {
	dodoc AUTHORS CHANGELOG README
	# Crazy build system...
	./build.sh --install --prefix "${D}/usr" || die "./build --install failed"
	make_desktop_entry gip "GIP IP Address Calculator" gnome-calc3 Network
}
