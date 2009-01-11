# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sbaz/sbaz-1.25.ebuild,v 1.1 2009/01/11 03:54:28 ali_bush Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A system used by Scala enthusiasts to share computer files with each other."
HOMEPAGE="http://www.lexspoon.org/sbaz/"
SRC_URI="http://www.lexspoon.org/${PN}/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP=">=dev-lang/scala-2.7.2"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-contrib
	=java-virtuals/servlet-api-2.4*
	${COMMON_DEP}"

src_compile() {
	local antopts=""
	use source && antopts="srcjar"

	ANT_OPTS="-Xmx512M" eant -Dscala.home="/usr/share/scala" \
		-Dservlet-api.jar="$(java-pkg_getjar --build-only servlet-api-2.4 servlet-api.jar)" \
		-Dant-contrib.jar="$(java-pkg_getjars --build-only ant-contrib)" \
		build.main ${antopts}
}

src_install() {
	local SBAZDIR="/usr/share/${PN}/"

	#sources are .scala so no use for java-pkg_dosrc
	if use source; then
		dodir "${SBAZDIR}/src"
		insinto "${SBAZDIR}/src"
		doins build/*-src.jar
	fi

	java-pkg_dojar "build/${PN}.jar"
	java-pkg_register-dependency scala scala-library.jar

	java-pkg_dolauncher "${PN}" \
		--java_args "-Xmx256m -Xms16M -Dsbaz.confdir=/etc/${PN}" \
		--main "sbaz.clui.CommandLine"
	dobin debian/command-scripts/sbaz-setup

	dodir "/etc/${PN}"
	insinto "/etc/${PN}"
	doins debian/default-universe
}

