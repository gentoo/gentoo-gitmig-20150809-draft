# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/externalfile/externalfile-1.2.0.ebuild,v 1.9 2008/05/26 21:54:59 tupone Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="Extends Zope to work with files in the filesystem."
HOMEPAGE="http://www.zope.org/Members/arielpartners/ExternalFile"
SRC_URI="${HOMEPAGE}/${PV}/ExternalFile-${NEW_PV}.zip"

LICENSE="ZPL"
KEYWORDS="~ppc x86"
RESTRICT="mirror"

RDEPEND="net-zope/zope"
DEPEND="app-arch/unzip"

ZPROD_LIST="ExternalFile"
