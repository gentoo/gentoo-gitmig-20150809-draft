# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaccessibility/kdeaccessibility-3.4.0_beta1.ebuild,v 1.4 2005/02/02 11:55:26 lanius Exp $

inherit kde-dist

DESCRIPTION="KDE accessibility module"
DEPEND="!x11-misc/kmousetool"
KEYWORDS="~x86 ~amd64"
IUSE="arts"

src_compile() {
	# see http://bugs.kde.org/show_bug.cgi?id=97106
	use arts || export DO_NOT_COMPILE="${DO_NOT_COMPILE} ksayit"

	kde_src_compile
}
