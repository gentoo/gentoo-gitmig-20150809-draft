# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cvsfile/cvsfile-0.9.0.ebuild,v 1.6 2007/07/02 15:21:14 peper Exp $

inherit zproduct

NEW_PV="${PV//./-}"
DESCRIPTION="CVSFile enables Zope content to be served out of files residing in CVS sandboxes, and provides access to common CVS functions through the web in the Zope Management Interface"
HOMEPAGE="http://zope.org/Members/arielpartners/CVSFile"
SRC_URI="${HOMEPAGE}/${PV}/CVSFile-${NEW_PV}.zip"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"
RESTRICT="mirror"

RDEPEND="net-zope/externalfile"
DEPEND="app-arch/unzip"

ZPROD_LIST="CVSFile"
