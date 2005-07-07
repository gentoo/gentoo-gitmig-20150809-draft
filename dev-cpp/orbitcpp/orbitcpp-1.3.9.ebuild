# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/orbitcpp/orbitcpp-1.3.9.ebuild,v 1.6 2005/07/07 14:48:23 iluxa Exp $

inherit gnome.org

DESCRIPTION="C++ Bindings for ORBit2"
HOMEPAGE="http://orbitcpp.sourceforge.net/"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~mips"
IUSE=""

RDEPEND=">=gnome-base/orbit-2.5
	>=dev-libs/libIDL-0.7.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dosym /usr/lib/libORBit-2-cpp.so.6.0.0 /usr/lib/libORBit-2-cpp.so.5
}
