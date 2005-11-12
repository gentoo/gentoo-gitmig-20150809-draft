# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdegraphics-meta/kdegraphics-meta-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:26 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdegraphics - merge this to pull in all kdegraphics-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~x86"
IUSE="gphoto2 scanner povray"

RDEPEND="gphoto2? ( $(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kamera) )
	$(deprange 3.5_beta1 $MAXKDEVER kde-base/kcoloredit)
	$(deprange $PV $MAXKDEVER kde-base/kdegraphics-kfile-plugins)
	$(deprange $PV $MAXKDEVER kde-base/kdvi)
	$(deprange $PV $MAXKDEVER kde-base/kfax)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kgamma)
	$(deprange $PV $MAXKDEVER kde-base/kghostview)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kiconedit)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kmrml)
	$(deprange $PV $MAXKDEVER kde-base/kolourpaint)
	scanner? ( $(deprange $PV $MAXKDEVER kde-base/kooka)
	    $(deprange $PV $MAXKDEVER kde-base/libkscan) )
	$(deprange $PV $MAXKDEVER kde-base/kpdf)
	povray? ( $(deprange $PV $MAXKDEVER kde-base/kpovmodeler) )
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kruler)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/ksnapshot)
	$(deprange $PV $MAXKDEVER kde-base/ksvg)
	$(deprange 3.5.0_beta2 $MAXKDEVER kde-base/kuickshow)
	$(deprange $PV $MAXKDEVER kde-base/kview)
	$(deprange $PV $MAXKDEVER kde-base/kviewshell)"
