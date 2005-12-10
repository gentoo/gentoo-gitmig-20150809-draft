# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-binding/jgoodies-binding-1.0.3.ebuild,v 1.1 2005/12/10 07:28:18 compnerd Exp $

inherit java-pkg

MY_V=${PV//./_}
DESCRIPTION="A Java library to bind object properties with UI components"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/binding-${MY_V}.zip"

LICENSE="BSD"
SLOT="1.0"
KEYWORDS="~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4.2
		dev-java/ant-core
		app-arch/unzip
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.4.2
		 >=dev-java/jgoodies-looks-1.0.5"

S=${WORKDIR}/binding-${PV}

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}

	# Clean up the directory structure
	rm -rf *.jar src/ lib/ examples/

	# Unpack the sources into the proper structure
	mkdir ${S}/src && cd ${S}/src
	unzip ${S}/binding-${PV}-src.zip &> /dev/null || die "unpack failed"

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build-${PV}.xml ${S}
}

src_compile() {
	local antflags="jar"

	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant -f build-${PV}.xml ${antflags} || die "compile failed"
}

src_install() {
	java-pkg_newjar binding-${PV}.jar binding.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r build/docs/*
}
