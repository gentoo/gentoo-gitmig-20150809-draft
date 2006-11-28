# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-sounds/kdeartwork-sounds-3.5.0.ebuild,v 1.20 2006/11/28 01:26:27 flameeyes Exp $

ARTS_REQUIRED="never"
RESTRICT="binchecks strip"

KMMODULE=sounds
KMNAME=kdeartwork
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Extra sound themes for kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
