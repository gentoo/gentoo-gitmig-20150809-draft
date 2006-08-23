# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.5.0.ebuild,v 1.4 2006/08/23 21:22:24 swegener Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.5"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.5.0*
		=dev-java/sun-jre-bin-1.5.0*
		=dev-java/diablo-jre-bin-1.5.0*
	)"
DEPEND=""
