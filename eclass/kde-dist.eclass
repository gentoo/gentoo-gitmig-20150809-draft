# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.1 2001/10/01 13:54:38 danarmak Exp $
# This is the kde ebuild for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# It can't be used for e.g. kdevelop, koffice because of their separate versionnig schemes.
inherit kde-base kde.org || die
ECLASS=kde-dist

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

DEPEND="$DEPEND ( kde-base/kdelibs-${PV} )"
RDEPEND="$RDEPEND ( kde-base/kdelibs-${PV} )"
