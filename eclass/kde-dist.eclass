# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.12 2002/05/11 09:57:59 danarmak Exp $
# This is the kde-dist eclass for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# Don't use it for e.g. kdevelop, koffice because of their separate versionnig schemes.
inherit kde-base kde.org
ECLASS=kde-dist

need-kde $PV

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

myconf="$myconf --enable-final"

LICENSE="GPL-2"
