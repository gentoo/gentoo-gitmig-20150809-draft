# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-3.0.ebuild,v 1.1 2010/08/31 14:54:35 nelchael Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
		dev-java/resin-servlet-api:${SLOT}
	)"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="resin-servlet-api-${SLOT}"
