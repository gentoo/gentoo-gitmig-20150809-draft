# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.4.1.ebuild,v 1.6 2010/01/11 11:03:47 ulm Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.4"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.4.1*
		=dev-java/kaffe-1.1*
	)"
DEPEND=""
