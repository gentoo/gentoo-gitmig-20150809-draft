# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/sun-jdk/sun-jdk-20080504.ebuild,v 1.1 2008/05/04 12:25:45 betelgeuse Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from Sun JDK"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/sun-jdk:1.6
			dev-java/sun-jdk:1.5
			dev-java/sun-jdk:1.4
			dev-java/diablo-jdk:1.5
		)
		>=dev-java/java-config-2.1.6
		"

JAVA_VIRTUAL_VM="sun-jdk-1.6 sun-jdk-1.5 sun-jdk-1.4 diable-jdk-1.5"
