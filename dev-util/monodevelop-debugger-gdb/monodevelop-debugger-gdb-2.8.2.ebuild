# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-debugger-gdb/monodevelop-debugger-gdb-2.8.2.ebuild,v 1.1 2011/11/23 19:04:42 pacho Exp $

EAPI="4"

inherit mono multilib versionator

DESCRIPTION="GDB Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-2.4
	=dev-util/monodevelop-$(get_version_component_range 1-2)*
	sys-devel/gdb"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	./configure --prefix=/usr
}

src_install() {
	default
	mono_multilib_comply
}
