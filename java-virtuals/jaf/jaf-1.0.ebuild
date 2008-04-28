# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jaf/jaf-1.0.ebuild,v 1.1 2008/04/28 00:56:42 betelgeuse Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for JavaBeans Activation Framework (JAF)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			=virtual/jdk-1.6*
			dev-java/sun-jaf:0
			dev-java/gnu-jaf:1
		)
		>=dev-java/java-config-2.1.6
		"

JAVA_VIRTUAL_PROVIDES="sun-javamail gnu-javamail-1"
JAVA_VIRTUAL_VM="sun-jdk-1.6 ibm-jdk-bin-1.6"
