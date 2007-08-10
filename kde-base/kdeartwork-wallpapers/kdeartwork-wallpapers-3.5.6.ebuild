# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-wallpapers/kdeartwork-wallpapers-3.5.6.ebuild,v 1.7 2007/08/10 13:55:09 angelos Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=wallpapers
KMNAME=kdeartwork
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Wallpapers from kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
