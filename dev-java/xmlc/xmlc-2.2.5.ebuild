# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlc/xmlc-2.2.5.ebuild,v 1.2 2005/07/15 10:39:11 axxo Exp $

inherit java-pkg

DESCRIPTION="Enhydra XMLC is the presentation technology that supports the needs of designers, developers and architects alike, delivering what JSP cannot - strict separation of markup and logic in a true object view of dynamic presentations."
HOMEPAGE="http://xmlc.objectweb.org/"
SRC_URI="http://download.forge.objectweb.org/${PN}/${PN}-src-${PV}.zip
	http://download.us.forge.objectweb.org/${PN}/${PN}-src-${PV}.zip"
DEPEND=">=virtual/jdk-1.3
	>=dev-java/ant-core-1.4
	jikes? ( >=dev-java/jikes-1.21 )"
RDEPEND=">=virtual/jre-1.3"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="doc jikes"

S="${WORKDIR}/${PN}-src-${PV}/"

src_compile() {
	local antflags="all-libs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar release/lib/*.jar
	dodoc release/lib/README
	# Move the generated documentation around
	use doc && mv ${PN}/modules/taskdef/doc ${PN}/modules/${PN}/doc/taskdef
	use doc && mv ${PN}/modules/wireless/doc ${PN}/modules/${PN}/doc/wireless
	use doc && mv ${PN}/modules/xhtml/doc ${PN}/modules/${PN}/doc/xhtml
	use doc && dohtml -r ${PN}/modules/xmlc/doc/*
}
