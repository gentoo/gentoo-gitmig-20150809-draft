# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-icewm-themes/kdeartwork-icewm-themes-3.5.7.ebuild,v 1.7 2007/08/10 13:57:26 angelos Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=icewm-themes
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)"

pkg_postinst() {
	kde_pkg_postinst
	elog "More IceWM themes are available installing x11-themes/icewm-themes"
}
