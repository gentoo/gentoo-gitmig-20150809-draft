# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaboodle/kaboodle-3.5.9.ebuild,v 1.4 2008/05/12 20:02:57 ranger Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="The Lean KDE Media Player"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

OLDRDEPEND="~kde-base/kdemultimedia-arts-$PV"
RDEPEND=">=kde-base/kdemultimedia-arts-${PV}:${SLOT}"

KMEXTRACTONLY="arts/"
