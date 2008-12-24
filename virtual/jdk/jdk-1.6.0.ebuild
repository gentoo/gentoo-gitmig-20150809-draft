# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.6.0.ebuild,v 1.10 2008/12/24 22:28:21 caster Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.6"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

# Keeps this and java-virtuals/jaf in sync
RDEPEND="|| (
		dev-java/icedtea6-bin
		=dev-java/sun-jdk-1.6.0*
		=dev-java/ibm-jdk-bin-1.6.0*
	)"
DEPEND=""
