# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-python/monodevelop-python-2.8.5.1.ebuild,v 1.1 2012/01/22 11:57:41 pacho Exp $

EAPI="4"

inherit mono multilib versionator

DESCRIPTION="Python Support for MonoDevelop."
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

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

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	./configure --prefix=/usr
}

src_install() {
	default
	mono_multilib_comply
}
