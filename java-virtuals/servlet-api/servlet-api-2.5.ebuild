# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.5.ebuild,v 1.1 2007/11/19 22:37:38 wltjr Exp $

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="2.5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
		=dev-java/tomcat-servlet-api-6.0*
		=dev-java/resin-servlet-api-3.1*
	)"
DEPEND=""
