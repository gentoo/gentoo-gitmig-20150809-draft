# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/forehead/forehead-1.0_beta5.ebuild,v 1.3 2006/03/14 04:49:06 nichoj Exp $

inherit java-pkg

DESCRIPTION="A framework to assist in controlling the run-time ClassLoader"
HOMEPAGE="http://forehead.werken.com"
SRC_URI="mirror://gentoo/forehead-${PV}.tbz2"

LICENSE="Werken-1.1.1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.3
		dev-java/ant-core
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/forehead

src_unpack() {
	unpack ${A} || die "Unpack failed!"

	# Copy over the new build.xml
	cp ${FILESDIR}/build.xml ${S}
}

src_compile() {
	cd ${S}

	local antflags="-Dversion=${PV}"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"

	ant ${antflags} || die "Compile failed!"
}

src_install() {
	java-pkg_newjar ${S}/dest/forehead-${PV}.jar ${PN}.jar

	use doc && java-pkg_dohtml docs/*
}
