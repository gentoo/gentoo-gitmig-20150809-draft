# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/saaj-api/saaj-api-1.3.ebuild,v 1.2 2008/05/03 17:48:01 ken69267 Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for SAAJ 1.3 (AKA JSR-67 MR3) API"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			=virtual/jdk-1.6*
			dev-java/jsr67:0
		)
		>=dev-java/java-config-2.1.6
		"

JAVA_VIRTUAL_PROVIDES="jsr67"
JAVA_VIRTUAL_VM="sun-jdk-1.6 ibm-jdk-bin-1.6"
