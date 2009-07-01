# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/saaj-api/saaj-api-1.3-r1.ebuild,v 1.2 2009/07/01 09:15:54 fauli Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for SAAJ 1.3 (AKA JSR-67 MR3) API"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			virtual/jre:1.6
			dev-java/jsr67:0
		)
		>=dev-java/java-config-2.1.8
		"

JAVA_VIRTUAL_PROVIDES="jsr67"
JAVA_VIRTUAL_VM="virtual/jre:1.6"
