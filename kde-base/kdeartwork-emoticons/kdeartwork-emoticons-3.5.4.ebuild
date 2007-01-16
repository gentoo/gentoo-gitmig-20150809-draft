# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-emoticons/kdeartwork-emoticons-3.5.4.ebuild,v 1.12 2007/01/16 19:53:08 flameeyes Exp $

ARTS_REQUIRED="never"

RESTRICT="binchecks strip"

KMMODULE=emoticons
KMNAME=kdeartwork
MAXKDEVER=3.5.6
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="EmotIcons (icons for things like smilies :-) for kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
