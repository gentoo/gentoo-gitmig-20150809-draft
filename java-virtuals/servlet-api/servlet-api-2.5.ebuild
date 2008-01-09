# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.5.ebuild,v 1.4 2008/01/09 17:30:05 wltjr Exp $

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="2.5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
		=dev-java/tomcat-servlet-api-6.0*
		=dev-java/resin-servlet-api-3.1*
	)"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-2.5 resin-servlet-api-2.5"
