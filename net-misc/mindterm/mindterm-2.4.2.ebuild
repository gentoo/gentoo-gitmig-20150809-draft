# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mindterm/mindterm-2.4.2.ebuild,v 1.8 2007/07/12 02:52:15 mr_bones_ Exp $

inherit eutils java-pkg

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/80_MindTerm/"
SRC_URI="http://www.appgate.com/products/80_MindTerm/110_MindTerm_Download/${P/-/_}-src.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc examples jikes"
RDEPEND=">=virtual/jre-1.3"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	dev-java/ant-core
	jikes? ( dev-java/jikes )"
S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-buildxml.patch
}

src_compile() {
	local antflags="mindterm.jar lite"
	use doc && antflags="${antflags} doc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "ant failed"

	# move javadoc location to install into proper location
	mv javadoc api
}

src_install() {
	java-pkg_dojar *.jar

	echo "#!/bin/sh" > ${PN}
	echo 'java -cp $(java-config -p mindterm) com.mindbright.application.MindTerm ${@}' >> ${PN}

	into /usr
	dobin ${PN}

	dodoc README.txt
	use doc && java-pkg_dohtml -r api

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
}
