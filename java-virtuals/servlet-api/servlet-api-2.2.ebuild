# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.2.ebuild,v 1.3 2008/01/09 07:05:37 josejx Exp $

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="as-is"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="=dev-java/tomcat-servlet-api-3"
DEPEND=""

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-2.2"
