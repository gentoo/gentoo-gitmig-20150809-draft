# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.5 2001/12/11 20:41:03 danarmak Exp $
# This is the kde-dist eclass for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# Don't use it for e.g. kdevelop, koffice because of their separate versionnig schemes.
inherit kde-base kde.org || die
ECLASS=kde-dist

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

need-kdelibs ${PV}

myconf="$myconf --enable-final"
