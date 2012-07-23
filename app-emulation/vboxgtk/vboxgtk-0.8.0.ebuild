# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vboxgtk/vboxgtk-0.8.0.ebuild,v 1.2 2012/07/23 15:46:28 hasufell Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit gnome2-utils distutils

DESCRIPTION="GTK frontend for VirtualBox"
HOMEPAGE="http://code.google.com/p/vboxgtk/"
SRC_URI="http://vboxgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| ( app-emulation/virtualbox[-headless,python,sdk]
		>=app-emulation/virtualbox-bin-2.2.2[python] )
	>=dev-python/pygobject-2.28.0:2"

PKG_LINGUAS="cs gl"
for PKG_LINGUA in ${PKG_LINGUAS}; do
	IUSE="${IUSE} linguas_${PKG_LINGUA/-/_}"
done

src_prepare() {
	distutils_src_prepare
	for LINGUA in ${PKG_LINGUAS}; do
		if ! use linguas_${LINGUA/-/_}; then
			rm -r po/"${LINGUA}".po || die "LINGUAS removal failed"
		fi
	done
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
