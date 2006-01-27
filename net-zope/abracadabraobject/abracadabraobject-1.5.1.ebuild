# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/abracadabraobject/abracadabraobject-1.5.1.ebuild,v 1.6 2006/01/27 02:23:30 vapier Exp $

inherit zproduct

DESCRIPTION="This can add pre-configured ZOPE-objects to folders through ZMI"
HOMEPAGE="http://www.zope.org/Members/mjablonski/AbracadabraObject"
SRC_URI="${HOMEPAGE}/AbracadabraObject-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="net-zope/propertyfolder
	net-zope/propertyobject"

ZPROD_LIST="AbracadabraObject"
