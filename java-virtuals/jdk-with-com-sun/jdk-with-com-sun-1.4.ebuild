# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jdk-with-com-sun/jdk-with-com-sun-1.4.ebuild,v 1.1 2008/09/12 21:39:24 betelgeuse Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from a JDK"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="1.4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/sun-jdk:1.4
			dev-java/blackdown-jdk:1.4.2
		)
		>=dev-java/java-config-2.1.6
		"

JAVA_VIRTUAL_VM="sun-jdk-1.4 blackdown-jdk-1.4.2"
