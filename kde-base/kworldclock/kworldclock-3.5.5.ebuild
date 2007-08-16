# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kworldclock/kworldclock-3.5.5.ebuild,v 1.1 2007/08/16 19:39:22 keytoaster Exp $

KMNAME=kdetoys

# kworldclock is called kworldwatch in the tarball, doc/ is not
KMMODULE=kworldwatch
KMNODOCS=true
KMEXTRA="doc/kworldclock"

MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE program that displays the part of the Earth lit up by the Sun"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""
