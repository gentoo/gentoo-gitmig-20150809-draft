# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-base.eclass,v 1.22 2003/02/28 09:15:04 vapier Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This is the kde ebuild for std. kde-dependant apps which follow configure/make/make install
# procedures and have std. configure options.

inherit kde
ECLASS=kde-base
INHERITED="$INHERITED $ECLASS"

newdepend /c

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://apps.kde.com/"
