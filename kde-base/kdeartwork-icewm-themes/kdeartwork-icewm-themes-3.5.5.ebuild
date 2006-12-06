# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-icewm-themes/kdeartwork-icewm-themes-3.5.5.ebuild,v 1.9 2006/12/06 15:50:15 kloeri Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=icewm-themes
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)"
