# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/orbitcpp/orbitcpp-1.3.6.ebuild,v 1.2 2003/06/19 21:47:24 liquidx Exp $

inherit gnome.org

DESCRIPTION="C++ Bindings for ORBit2"
HOMEPAGE="http://orbitcpp.sourceforge.net/"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=gnome-base/ORBit2-2.5
	>=dev-libs/libIDL-0.7.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dosym /usr/lib/libORBit-2-cpp.so.6.0.0 /usr/lib/libORBit-2-cpp.so.5
}
