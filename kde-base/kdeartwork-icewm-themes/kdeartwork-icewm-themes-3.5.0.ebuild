# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-icewm-themes/kdeartwork-icewm-themes-3.5.0.ebuild,v 1.18 2006/09/03 14:06:43 kloeri Exp $

KMMODULE=icewm-themes
KMNAME=kdeartwork
MAXKDEVER=3.5.4
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Themes for IceWM from the kdeartwork package."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
DEPEND=""
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdeartwork-kwin-styles)"
