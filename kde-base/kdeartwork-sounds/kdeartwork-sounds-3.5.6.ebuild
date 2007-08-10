# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-sounds/kdeartwork-sounds-3.5.6.ebuild,v 1.8 2007/08/10 13:55:50 angelos Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=sounds
KMNAME=kdeartwork
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra sound themes for kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
