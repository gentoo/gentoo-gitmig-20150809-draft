# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.5.5.ebuild,v 1.10 2007/08/30 17:16:17 drac Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="alsa"

DEPEND="media-libs/akode
	alsa? ( media-libs/alsa-lib )"

RDEPEND="${DEPEND}
	|| ( app-accessibility/festival
	     app-accessibility/epos
	     app-accessibility/flite
	     app-accessibility/freetts )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="--with-akode
		$(use_with alsa) --without-gstreamer"

	kde_src_compile
}
