# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/j2ssh/j2ssh-0.2.7.ebuild,v 1.1 2004/04/10 15:55:38 zx Exp $

inherit java-pkg

DESCRIPTION="Java SSH API"
HOMEPAGE="http://sourceforge.net/projects/sshtools/"
SRC_URI="mirror://sourceforge/sshtools/j2ssh-${PV}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86"
DEPEND=">=virtual/jdk-1.3
		dev-java/ant
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.3"

S="${WORKDIR}/${PN}"

src_compile() {
	local antflags="build"
	use doc && antflags="${antflags} javadoc"
	use jikes && antflag="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags}
}

src_install() {
	java-pkg_dojar dist/lib/*.jar
	insinto /usr/share/${PN}
	doins j2ssh.properties
	use doc && dohtml -r docs/ && cp -R ${S}/examples ${D}/usr/share/${PN}
}
