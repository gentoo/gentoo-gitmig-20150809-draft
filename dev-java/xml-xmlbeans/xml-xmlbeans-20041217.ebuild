# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-xmlbeans/xml-xmlbeans-20041217.ebuild,v 1.4 2005/01/08 02:48:45 luckyduck Exp $

inherit eutils java-pkg

DESCRIPTION="An XML-Java binding tool"
HOMEPAGE="http://xmlbeans.apache.org/"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"

IUSE="doc junit source"

DEPEND=">=virtual/jdk-1.4
	junit? ( >=dev-java/ant-1.6.2 )
	!junit? ( >=dev-java/ant-core-1.6.2 )
	source? ( app-arch/zip )
	${RDEPEND}"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jaxen-1.1_beta2*
	junit? ( >=dev-java/junit-3.8 )"

S=${WORKDIR}/${P}/v1

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/xml-xmlbeans-gentoo.patch

	cd ${S}/external/lib
	rm -f jaxen-1.1-beta-2.jar junit.jar

	java-pkg_jar-from jaxen-1.1 jaxen-1.1-beta-2-dev.jar jaxen-1.1-beta-2.jar
	if use junit; then
		java-pkg_jar-from junit
	fi
}

src_compile() {
	local antflags="xbean.jar"
	if use doc; then
		antflags="${antflags} docs"
	fi
	if use junit; then
		antflags="${antflags} random.jar drt.jar drt"
	fi
	if use source; then
		antflags="${antflags} sources"
	fi
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/lib/xbean*.jar

	dodoc CHANGES.txt LICENSE.txt NOTICE.txt README.txt
	if use doc; then
		java-pkg_dohtml -r build/docs/*
	fi
	if use source; then
		dodir /usr/share/doc/${PF}/source
		cp build/ar/xbeansrc.zip ${D}/usr/share/doc/${PF}/source
	fi
}
