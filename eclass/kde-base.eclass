# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-base.eclass,v 1.9 2001/10/01 13:54:38 danarmak Exp $
# This is the kde ebuild for std. kde-dependant apps which follow configure/make/make install
# procedures and have std. configure options.
inherit c kde || die
ECLASS=kde-base

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://apps.kde.com/"

DEPEND="${DEPEND}
	objprelink? ( dev-util/objprelink )
	x11-libs/qt-x11"
RDEPEND="${RDEPEND}
	x11-libs/qt-x11"




