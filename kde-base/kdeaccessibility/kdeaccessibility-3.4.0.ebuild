# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.0.ebuild,v 1.3 2005/03/18 18:26:30 morfic Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="arts gstreamer"

DEPEND="gstreamer? ( >=media-libs/gstreamer-0.8.7 )"

RDEPEND="${DEPEND}
	arts? ( || ( app-accessibility/festival
		     app-accessibility/epos
		     app-accessibility/flite
		     app-accessibility/freetts ) )"

src_compile() {
	myconf="$(use_enable gstreamer kttsd-gstreamer)"

	kde_src_compile
}
