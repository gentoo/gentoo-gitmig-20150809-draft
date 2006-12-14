# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.6.0.ebuild,v 1.1 2006/12/14 00:30:20 caster Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.6"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.6.0*
		=dev-java/sun-jre-bin-1.6.0*
	)"
DEPEND=""
