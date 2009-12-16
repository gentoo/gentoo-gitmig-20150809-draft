# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jaxp-virtual/jaxp-virtual-1.4.ebuild,v 1.3 2009/12/16 19:31:17 fauli Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for Java API for XML Processing (JAXP)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND="|| (
			=virtual/jdk-1.6*
			>=dev-java/jaxp-1.4-r1:0
		)"

JAVA_VIRTUAL_PROVIDES="jaxp"
JAVA_VIRTUAL_VM="icedtea6 sun-jdk-1.6 ibm-jdk-bin-1.6"
