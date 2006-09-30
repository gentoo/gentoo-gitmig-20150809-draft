# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jvyaml/jvyaml-0.1.ebuild,v 1.1 2006/09/30 02:20:41 nichoj Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java YAML parser and emitter"
HOMEPAGE="https://jvyaml.dev.java.net/"
SRC_URI="https://${PN}.dev.java.net/files/documents/5215/35811/${PN}-src-${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="source"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar lib/${PN}.jar
	dodoc README
	dodoc CREDITS
	use source && java-pkg_dosrc src/*
}
