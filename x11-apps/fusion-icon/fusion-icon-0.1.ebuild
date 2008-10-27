# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fusion-icon/fusion-icon-0.1.ebuild,v 1.1 2008/10/27 00:48:37 jmbsvicetto Exp $

inherit gnome2-utils python

MINIMUM_COMPIZ_RELEASE=0.6.0

DESCRIPTION="Compiz Fusion Tray Icon and Manager"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="http://dev.gentoo.org/~jmbsvicetto/distfiles/desktop-effects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"
RESTRICT="mirror"

RDEPEND="
	>=dev-python/compizconfig-python-${MINIMUM_COMPIZ_RELEASE}
	virtual/python
	>=x11-wm/compiz-${MINIMUM_COMPIZ_RELEASE}
	gtk? ( >=dev-python/pygtk-2.10 )
	qt4? ( dev-python/PyQt4 )"

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
	python_version
	python_mod_optimize	"${ROOT}usr/$(get_libdir)/python${PYVER}"/site-packages/FusionIcon

	use gtk && gnome2_icon_cache_update

	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	einfo "Please report all bugs to #gentoo-desktop-effects"
	einfo "Thank you on behalf of the Gentoo Desktop-Effects team"
}

pkg_postrm() {
	python_mod_cleanup
}
