# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.0.ebuild,v 1.5 2005/05/16 11:08:27 lanius Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~ia64"
IUSE="arts gstreamer"

DEPEND="gstreamer? ( >=media-libs/gstreamer-0.8.7 )"

RDEPEND="${DEPEND}
	arts? ( || ( app-accessibility/festival
		     app-accessibility/epos
		     app-accessibility/flite
		     app-accessibility/freetts ) )

	gstreamer? ( || ( app-accessibility/festival
		     app-accessibility/epos
		     app-accessibility/flite ) )"

pkg_setup() {
	kde_pkg_setup
	use gstreamer && {
		ewarn "gstreamer support in kdeaccessibility is experimental"
	}
}

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-noarts.patch
}

src_compile() {
	myconf="$(use_enable gstreamer kttsd-gstreamer)"
	kde_src_compile
}
