# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/saaj-api/saaj-api-1.3-r2.ebuild,v 1.3 2012/03/10 16:22:33 ranger Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for SAAJ 1.3 (AKA JSR-67 MR3) API"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			>=virtual/jre-1.6
			dev-java/jsr67:0
		)"

JAVA_VIRTUAL_PROVIDES="jsr67"
JAVA_VIRTUAL_VM=">=virtual/jre-1.6"
