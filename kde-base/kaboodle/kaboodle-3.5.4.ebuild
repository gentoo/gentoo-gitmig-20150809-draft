# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaboodle/kaboodle-3.5.4.ebuild,v 1.1 2006/07/25 02:55:58 flameeyes Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="The Lean KDE Media Player"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

OLDRDEPEND="~kde-base/kdemultimedia-arts-$PV"
RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kdemultimedia-arts)"

KMEXTRACTONLY="arts/"
