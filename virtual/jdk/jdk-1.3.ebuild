# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.3.ebuild,v 1.1 2006/07/06 10:33:58 nelchael Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.3"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="|| (
		=dev-java/blackdown-jdk-1.3*
		=dev-java/sun-jdk-1.3*
		=dev-java/compaq-jdk-1.3*
	)"
RDEPEND="${DEPEND}"
