# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.5.ebuild,v 1.1 2006/07/06 10:33:58 nelchael Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.5"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

DEPEND="|| (
		=dev-java/sun-jdk-1.5*
		=dev-java/ibm-jdk-bin-1.5*
		=dev-java/jrockit-jdk-bin-1.5*
	)"
RDEPEND="${DEPEND}"
