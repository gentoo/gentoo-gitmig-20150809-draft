# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-python/monodevelop-python-2.5.93.ebuild,v 1.1 2011/08/20 08:45:20 ali_bush Exp $

EAPI=3

inherit mono multilib versionator

DESCRIPTION="Python Support for MonoDevelop."
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://monodevelop.com/files/Linux/tarballs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.8
	=dev-util/monodevelop-$(get_version_component_range 1-2)*"

DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19"

src_configure() {
	./configure --prefix=/usr
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	mono_multilib_comply
}
