# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.0_beta1.ebuild,v 1.10 2004/10/16 23:10:06 axxo Exp $

inherit java-pkg

DESCRIPTION="A code-generation engine primarily for EJB"
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV/_/-}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="jikes"

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	jikes? ( dev-java/jikes )
	>=dev-java/ant-1.5"

S=${WORKDIR}/

src_unpack() {
	unpack ${A}
	if use jikes ; then
		einfo "Configuring build for Jikes"
		cp build.properties build.properties~ \
			&& sed -e 's/compiler = modern/compiler = jikes/' <build.properties~ >build.properties
	fi
}

src_compile() {
	ant || die
}

src_install() {
	java-pkg_dojar target/lib/*.jar
	dodoc LICENSE.txt
	cp -r target/docs target/generated-xdocs samples ${D}/usr/share/doc/${P}
}
