# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jdk/jdk-1.4.1.ebuild,v 1.3 2006/08/23 21:20:58 swegener Exp $

DESCRIPTION="Virtual for JDK"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
		=dev-java/blackdown-jdk-1.4.1*
		=dev-java/kaffe-1.1*
	)"
DEPEND=""
