# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cvsfile/cvsfile-0.9.0.ebuild,v 1.3 2004/09/04 17:14:13 axxo Exp $

inherit zproduct

NEW_PV="${PV//./-}"

RESTRICT="nomirror"
DESCRIPTION="CVSFile enables Zope content to be served out of files residing in CVS sandboxes, and provides access to common CVS functions through the web in the Zope Management Interface."
HOMEPAGE="http://zope.org/Members/arielpartners/CVSFile"
SRC_URI="${HOMEPAGE}/${PV}/CVSFile-${NEW_PV}.zip"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND="net-zope/externalfile
	${RDEPEND}"

ZPROD_LIST="CVSFile"
