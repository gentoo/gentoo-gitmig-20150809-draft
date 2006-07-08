# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.4.1.ebuild,v 1.2 2006/07/08 18:38:34 nelchael Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.4"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="|| (
		=dev-java/blackdown-jre-1.4.1*
		=dev-java/kaffe-1.1*
		=virtual/jdk-1.4.1*
	)"
RDEPEND="${DEPEND}"
