# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.4.ebuild,v 1.1 2006/07/06 10:28:48 nelchael Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.4"
KEYWORDS="amd64 ia64 ppc ppc64 ~s390 x86"
IUSE=""

DEPEND="|| (
		=dev-java/blackdown-jre-1.4*
		=dev-java/kaffe-1.1*
		=dev-java/sun-jre-bin-1.4*
		=dev-java/ibm-jre-bin-1.4*
		=virtual/jdk-1.4*
	)"
RDEPEND="${DEPEND}"
