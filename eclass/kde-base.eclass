# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-base.eclass,v 1.15 2002/07/12 21:42:38 danarmak Exp $
# This is the kde ebuild for std. kde-dependant apps which follow configure/make/make install
# procedures and have std. configure options.
inherit kde
INHERITED="$INHERITED $ECLASS"
ECLASS=kde-base
newdepend /c

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://apps.kde.com/"





