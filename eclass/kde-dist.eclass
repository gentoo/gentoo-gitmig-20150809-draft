# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.13 2002/07/12 21:40:42 danarmak Exp $
# This is the kde-dist eclass for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# Don't use it for e.g. kdevelop, koffice because of their separate versionnig schemes.
inherit kde-base kde.org
ECLASS=kde-dist
INHERITED="$INHERITED $ECLASS"

need-kde $PV

SLOT="${KDEMAJORVER}.${KDEMINORVER}"

# 3.1 prereleases
[ "$PV" == "3.1_alpha1" ] && S=${WORKDIR}/${PN}-3.0.6

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

myconf="$myconf --enable-final"

LICENSE="GPL-2"

