# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.0_beta1.ebuild,v 1.3 2005/01/16 12:02:05 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
DEPEND="!x11-misc/kmousetool"
KEYWORDS="~x86"
IUSE="arts"

src_compile() {
	# see http://bugs.kde.org/show_bug.cgi?id=97106
	use arts || export DO_NOT_COMPILE="${DO_NOT_COMPILE} ksayit"

	kde_src_compile
}
