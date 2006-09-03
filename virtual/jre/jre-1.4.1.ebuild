# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.4.1.ebuild,v 1.5 2006/09/03 01:35:51 nichoj Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE="http://java.sun.com/"
SRC_URI=""

LICENSE="as-is"
SLOT="1.4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.4.1*
		=dev-java/kaffe-1.1*
	)"
DEPEND=""
