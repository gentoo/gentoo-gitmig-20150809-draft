# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/abracadabraobject/abracadabraobject-1.5.1.ebuild,v 1.4 2004/03/27 17:08:09 lanius Exp $

inherit zproduct

DESCRIPTION="This can add pre-configured ZOPE-objects to folders through ZMI."
HOMEPAGE="http://www.zope.org/Members/mjablonski/AbracadabraObject"
SRC_URI="${HOMEPAGE}/AbracadabraObject-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
RDEPEND="net-zope/propertyfolder
	net-zope/propertyobject
	${RDEPEND}"

ZPROD_LIST="AbracadabraObject"
