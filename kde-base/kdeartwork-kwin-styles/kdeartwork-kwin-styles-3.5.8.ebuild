# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kwin-styles/kdeartwork-kwin-styles-3.5.8.ebuild,v 1.7 2008/03/04 04:22:26 jer Exp $

ARTS_REQUIRED="never"

KMMODULE=kwin-styles
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Window styles for kde"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"
