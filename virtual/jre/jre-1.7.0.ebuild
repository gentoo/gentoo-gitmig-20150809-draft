# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.7.0.ebuild,v 1.2 2011/09/11 04:09:05 serkan Exp $

DESCRIPTION="Virtual for JRE"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="1.7"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| (
		=virtual/jdk-1.7.0*
		=dev-java/oracle-jre-bin-1.7.0*
	)"
DEPEND=""
