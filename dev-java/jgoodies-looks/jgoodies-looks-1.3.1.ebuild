# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-1.3.1.ebuild,v 1.1 2005/03/30 23:33:42 compnerd Exp $

inherit java-pkg

MY_V=${PV//./_}
DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/looks-${MY_V}.zip"

LICENSE="BSD"
SLOT="1.3"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4.2
		>=dev-java/ant-core-1.4
		  app-arch/unzip
		jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/looks-${PV}"

src_unpack() {
	unpack ${A} || die "Unpack failed!"
	cd ${S}

	# Clean up the structure
	rm -rf *.jar examples/ src/

	# Unpack the sources into the proper structure
	mkdir ${S}/src && cd ${S}/src
	unzip ${S}/looks-${PV}-src.zip &> /dev/null || die "Unpack Failed"

	# Copy the Gentoo'ized build.xml
	cp ${FILESDIR}/build-${PV}.xml ${S}
	cp ${FILESDIR}/plastic-${PV}.txt ${S}/plastic.txt
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant -f build-${PV}.xml ${antflags} || die "Compile failed"
}

src_install() {
	java-pkg_dojar looks-${PV}.jar

	dodoc LICENSE.txt RELEASE-NOTES.txt
	if use doc ; then
		java-pkg_dohtml -r build/doc
	fi
}
