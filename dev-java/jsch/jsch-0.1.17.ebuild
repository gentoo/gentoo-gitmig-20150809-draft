# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsch/jsch-0.1.17.ebuild,v 1.6 2005/03/31 15:10:11 axxo Exp $

inherit java-pkg

DESCRIPTION="JSch is a pure Java implementation of SSH2."
HOMEPAGE="http://www.jcraft.com/jsch/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.zip"
LICENSE="jcraft"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="doc jikes"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.6
	>=dev-java/jzlib-1.0.3
	app-arch/unzip
	jikes? ( >=dev-java/jikes-1.17 )
	ppc? ( dev-java/gnu-crypto )"
RDEPEND=">=virtual/jdk-1.4"

src_compile() {
	local antflags="dist"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	if use ppc; then
		ant $(java-config -p gnu-crypto) ${antflags} || die "compilation failed"
	else
		ant ${antflags} || die "compilation failed"
	fi
}

src_install() {
	mv dist/lib/jsch{*,}.jar
	java-pkg_dojar dist/lib/jsch.jar || die "installation failed"
	use doc && java-pkg_dohtml -r javadoc/*
	dodoc LICENSE.txt README ChangeLog
}
