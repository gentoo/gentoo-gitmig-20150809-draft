# Copyright 2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aterm-java/aterm-java-1.6.ebuild,v 1.3 2004/07/20 19:51:11 karltk Exp $

inherit java-pkg

DESCRIPTION="Java library for ATerm exchange"
HOMEPAGE="http://www.cwi.nl/htbin/sen1/twiki/bin/view/SEN1/ATermLibrary"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/aterm-java/aterm-java-1.6.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	dev-java/jjtraveler"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/shared-objects-1.4"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "Failed to configure"
	emake || die "Failed to compile"
	(
		echo "#! /bin/sh"
		echo "java-config -p aterm-java-1"
	) > aterm-java-config
	tar zxvf aterm-javadoc.tar.gz && mv aterm-javadoc api
}

src_install() {
	java-pkg_dojar aterm-1.6.jar

	exeinto /usr/bin
	doexe aterm-java-config

	dohtml -r api
	dodoc AUTHORS COPYING INSTALL ChangeLog
}
