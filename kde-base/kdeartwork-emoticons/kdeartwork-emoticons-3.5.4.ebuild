# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-emoticons/kdeartwork-emoticons-3.5.4.ebuild,v 1.13 2007/05/24 11:14:58 carlo Exp $

ARTS_REQUIRED="never"

RESTRICT="binchecks strip"

KMMODULE=emoticons
KMNAME=kdeartwork
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="EmotIcons (icons for things like smilies :-) for kde"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND=""
