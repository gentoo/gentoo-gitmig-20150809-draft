# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/squishdot/squishdot-1.5.0.ebuild,v 1.4 2003/09/08 06:53:31 msterret Exp $

inherit zproduct
NEW_PV="${PV//./-}"

DESCRIPTION="A web-based news publishing and discussion product for Zope."
HOMEPAGE="http://squishdot.org/"
SRC_URI="${HOMEPAGE}/Download/Squishdot-${NEW_PV}.tar.gz"
LICENSE="ZPL"

ZPROD_LIST="Squishdot"
MYDOC="License.txt Changes.txt Credits.txt ${MYDOC}"




