# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fusion-icon/fusion-icon-0.1-r1.ebuild,v 1.3 2011/04/05 05:31:23 ulm Exp $

EAPI="2"

inherit gnome2-utils python

MINIMUM_COMPIZ_RELEASE=0.6.0

DESCRIPTION="Compiz Fusion Tray Icon and Manager"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"

RDEPEND="
	>=dev-python/compizconfig-python-${MINIMUM_COMPIZ_RELEASE}
	dev-lang/python
	>=x11-wm/compiz-${MINIMUM_COMPIZ_RELEASE}
	gtk? ( >=dev-python/pygtk-2.10 )
	qt4? ( dev-python/PyQt4[X] )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	x11-apps/xvinfo"

S="${WORKDIR}/${PN}"

src_install() {
	use gtk && interfaces="${interfaces} gtk"
	use qt4 && interfaces="${interfaces} qt4"
	emake "interfaces=${interfaces}" DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	python_need_rebuild
	python_mod_optimize $(python_get_sitedir)/FusionIcon

	use gtk && gnome2_icon_cache_update
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/FusionIcon
}
