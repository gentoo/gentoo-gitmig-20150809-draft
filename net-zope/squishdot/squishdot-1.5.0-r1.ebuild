# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/squishdot/squishdot-1.5.0-r1.ebuild,v 1.1 2005/05/08 03:03:35 nerdboy Exp $

inherit zproduct
NEW_PV="${PV//./-}"

DESCRIPTION="A web-based news publishing and discussion product for Zope."
HOMEPAGE="http://squishdot.org/"
SRC_URI="${HOMEPAGE}/Download/Squishdot-${NEW_PV}.tar.gz"
LICENSE="ZPL"

KEYWORDS="x86 ~sparc"
IUSE=""

ZPROD_LIST="Squishdot"
MYDOC="License.txt Changes.txt Credits.txt ${MYDOC}"




