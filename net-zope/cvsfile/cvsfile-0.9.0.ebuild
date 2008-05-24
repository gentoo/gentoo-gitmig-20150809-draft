# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cvsfile/cvsfile-0.9.0.ebuild,v 1.7 2008/05/24 21:28:41 tupone Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="Enables Zope content to be served out of files residing in CVS"
HOMEPAGE="http://zope.org/Members/arielpartners/CVSFile"
SRC_URI="${HOMEPAGE}/${PV}/CVSFile-${NEW_PV}.zip"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"
RESTRICT="mirror"

RDEPEND="net-zope/externalfile"
DEPEND="app-arch/unzip"

ZPROD_LIST="CVSFile"
