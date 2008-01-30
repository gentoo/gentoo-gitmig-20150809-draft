# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-emoticons/kdeartwork-emoticons-3.5.8.ebuild,v 1.5 2008/01/30 17:22:39 ranger Exp $

ARTS_REQUIRED="never"

RESTRICT="binchecks strip"

KMMODULE=emoticons
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="EmotIcons (icons for things like smilies :-) for kde"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
