# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-icewm-themes/kdeartwork-icewm-themes-3.5.6.ebuild,v 1.1 2007/01/16 19:53:36 flameeyes Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=icewm-themes
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)"
