# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jdk-with-com-sun/jdk-with-com-sun-20100419.ebuild,v 1.5 2011/10/30 14:08:24 caster Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from a JDK"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/icedtea-bin:6
			dev-java/icedtea:6
			dev-java/sun-jdk:1.6
			dev-java/sun-jdk:1.5
			dev-java/sun-jdk:1.4
			dev-java/diablo-jdk:1.6
			dev-java/blackdown-jdk:1.4.2
		)
		>=dev-java/java-config-2.1.6
		"

JAVA_VIRTUAL_VM="icedtea6-bin icedtea6 sun-jdk-1.6 sun-jdk-1.5 sun-jdk-1.4 diablo-jdk-1.6 blackdown-jdk-1.4.2"
