# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.3.ebuild,v 1.2 2007/11/20 09:06:55 ali_bush Exp $

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="2.3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-java/tomcat-servlet-api-4*"
DEPEND=""

JAVA_VIRTUALS_PROVIDES="tomcat-servlet-api-2.3"
