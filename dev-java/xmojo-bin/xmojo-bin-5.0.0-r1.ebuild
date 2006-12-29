# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmojo-bin/xmojo-bin-5.0.0-r1.ebuild,v 1.1 2006/12/29 00:53:43 betelgeuse Exp $

inherit java-pkg-2

DESCRIPTION="JMX implementation for instrumenting Java/J2EE applications"
HOMEPAGE="http://www.xmojo.org/"
SRC_URI="http://www.xmojo.org/products/xmojo/downloads/XMOJO_5_0_0.tar.gz"
LICENSE="LGPL-2.1"
SLOT="5.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND=""
RDEPEND=">=virtual/jre-1.4
	=dev-java/crimson-1.1*
	>=dev-java/xalan-2.5
	>=dev-java/gnu-jaxp-1.0"
#	=dev-java/jetty-4.2*
S=${WORKDIR}/XMOJO

src_compile() {
	# karltk: We should really look through this package once more. It's
	# supposed to plug into a servlet container, too, so we need to test
	# it with jetty and tomcat. For now, I only use it to bootstrap
	# groovy.
	einfo "This is a binary package"
}

src_install() {
	java-pkg_dojar lib/xmojo.jar lib/xmojoadaptors.jar lib/xmojotools.jar lib/xmojoutils.jar
	java-pkg_dojar lib/AdventNetUpdateManager.jar

	if use doc ; then
		java-pkg_dohtml -r docs/*
	fi

	dodoc COPYRIGHT LICENSE_AGREEMENT README.html
}

