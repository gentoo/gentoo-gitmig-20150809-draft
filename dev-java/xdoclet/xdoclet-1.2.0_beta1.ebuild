# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xdoclet/xdoclet-1.2.0_beta1.ebuild,v 1.3 2003/02/13 10:23:47 vapier Exp $

DESCRIPTION="A code-generation engine primarily for EJB"
HOMEPAGE="http://xdoclet.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV/_/-}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=virtual/jdk-1.3"
DEPEND="${RDEPEND}
	dev-java/jikes
	>=dev-java/ant-1.5"

S=${WORKDIR}/

src_unpack() {
	unpack ${A}
	einfo "Configuring build for Jikes"
	cp build.properties build.properties~ \
		&& sed -e 's/compiler = modern/compiler = jikes/' <build.properties~ >build.properties
}

src_compile() {
	ant || die
}

src_install() {
	dojar target/lib/*.jar
	dodoc LICENSE.txt
	cp -r target/docs target/generated-xdocs samples ${D}/usr/share/doc/${P}
}
