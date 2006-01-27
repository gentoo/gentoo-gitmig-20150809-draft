# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/squishdot/squishdot-1.5.0.ebuild,v 1.7 2006/01/27 02:47:26 vapier Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="A web-based news publishing and discussion product for Zope"
HOMEPAGE="http://squishdot.org/"
SRC_URI="${HOMEPAGE}/Download/Squishdot-${NEW_PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="x86"

ZPROD_LIST="Squishdot"
MYDOC="Changes.txt Credits.txt ${MYDOC}"
