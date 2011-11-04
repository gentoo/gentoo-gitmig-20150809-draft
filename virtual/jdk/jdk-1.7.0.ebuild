# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.7.0.ebuild,v 1.3 2011/11/04 15:14:43 caster Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.7"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
		=dev-java/icedtea-7*
		=dev-java/oracle-jdk-bin-1.7.0*
	)"
DEPEND=""
