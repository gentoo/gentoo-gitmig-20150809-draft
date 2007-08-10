# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-meta/kdegraphics-meta-3.5.7.ebuild,v 1.6 2007/08/10 15:07:43 angelos Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="gphoto2 scanner povray imlib"

RDEPEND="gphoto2? ( $(deprange $PV $MAXKDEVER kde-base/kamera) )
	$(deprange $PV $MAXKDEVER kde-base/kcoloredit)
	$(deprange $PV $MAXKDEVER kde-base/kdegraphics-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kdvi)
	$(deprange $PV $MAXKDEVER kde-base/kfax)
	$(deprange $PV $MAXKDEVER kde-base/kgamma)
	$(deprange $PV $MAXKDEVER kde-base/kghostview)
	$(deprange $PV $MAXKDEVER kde-base/kiconedit)
	$(deprange $PV $MAXKDEVER kde-base/kmrml)
	$(deprange $PV $MAXKDEVER kde-base/kolourpaint)
	scanner? ( $(deprange $PV $MAXKDEVER kde-base/kooka)
	    $(deprange $PV $MAXKDEVER kde-base/libkscan) )
	$(deprange $PV $MAXKDEVER kde-base/kpdf)
	povray? ( $(deprange $PV $MAXKDEVER kde-base/kpovmodeler) )
	$(deprange $PV $MAXKDEVER kde-base/kruler)
	$(deprange $PV $MAXKDEVER kde-base/ksnapshot)
	$(deprange $PV $MAXKDEVER kde-base/ksvg)
	imlib? ( $(deprange $PV $MAXKDEVER kde-base/kuickshow) )
	$(deprange $PV $MAXKDEVER kde-base/kview)
	$(deprange $PV $MAXKDEVER kde-base/kviewshell)"
