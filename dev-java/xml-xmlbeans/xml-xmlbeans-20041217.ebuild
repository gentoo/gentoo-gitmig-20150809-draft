# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xml-xmlbeans/xml-xmlbeans-20041217.ebuild,v 1.2 2004/12/24 12:46:25 axxo Exp $

inherit eutils java-pkg

DESCRIPTION="An XML-Java binding tool"
HOMEPAGE="http://xmlbeans.apache.org/"
SRC_URI="http://dev.gentoo.org/~karltk/projects/java/distfiles/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"

IUSE="doc"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6.2
	${RDEPEND}"
RDEPEND=">=virtual/jre-1.4
	=dev-java/jaxen-1.1_beta2*"

S=${WORKDIR}/${P}/v1

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/xml-xmlbeans-gentoo.patch

	cd ${S}/external/lib
	rm -f jaxen-1.1-beta-2.jar junit.jar

	java-pkg_jar-from jaxen-1.1 jaxen-1.1-beta-2-dev.jar jaxen-1.1-beta-2.jar
	java-pkg_jar-from junit

}

src_compile() {
	local antflags="default"
	if use doc; then
		antflags="${antflags} docs"
	fi
	ant ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/lib/xbean*.jar

	dodoc CHANGES.txt LICENSE.txt NOTICE.txt README.txt
	if use doc; then
		java-pkg_dohtml -r build/docs/*
	fi
}
