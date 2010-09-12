# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-debugger-gdb/monodevelop-debugger-gdb-2.4.ebuild,v 1.2 2010/09/12 03:35:45 phajdan.jr Exp $

EAPI=2

inherit mono multilib versionator

DESCRIPTION="GDB Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-2.4
	=dev-util/monodevelop-$(get_version_component_range 1-2)
	 sys-devel/gdb"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23"

src_configure() {
	./configure \
		--prefix=/usr		\
	|| die "configure failed"
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
	mono_multilib_comply
}
