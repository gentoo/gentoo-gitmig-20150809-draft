# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/orbitcpp/orbitcpp-1.3.6.ebuild,v 1.1 2003/06/17 15:54:54 foser Exp $

inherit gnome.org

DESCRIPTION="C++ Bindings for ORBit2"
HOMEPAGE="http://www.gnome.org/"
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
}
