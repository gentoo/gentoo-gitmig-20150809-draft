# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vboxgtk/vboxgtk-0.5.0-r1.ebuild,v 1.2 2011/01/07 15:20:50 polynomial-c Exp $

EAPI="2"

SUPPORT_PYTHON_ABIS="1"

inherit gnome2-utils distutils

DESCRIPTION="GTK frontend for VirtualBox"
HOMEPAGE="http://vboxgtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="linguas_es"

DEPEND=""
RDEPEND="
	|| ( app-emulation/virtualbox[-headless,sdk]
		>=app-emulation/virtualbox-bin-2.2.2 )
	>=dev-python/pygtk-2.14.0"

RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	if ! use linguas_es; then
		rm po/es.po || die "rm failed"
	fi
	python_convert_shebangs -r 2 .
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	distutils_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm
	gnome2_icon_cache_update
}
