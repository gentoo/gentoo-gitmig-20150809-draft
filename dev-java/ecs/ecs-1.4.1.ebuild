# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecs/ecs-1.4.1.ebuild,v 1.8 2004/10/20 06:00:38 absinthe Exp $

inherit java-pkg

DESCRIPTION="Java library to generate markup language text such as HTML and XML."
HOMEPAGE="http://jakarta.apache.org/ecs"
SRC_URI="http://jakarta.apache.org/builds/jakarta-ecs/release/v${PV}/${PN}-${PV}.tar.gz"
LICENSE="Apache-1.1"
DEPEND="virtual/jdk
	>=dev-java/ant-1.4"
RDEPEND="virtual/jdk"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc"

S=${WORKDIR}/${P/jakarta-/}

src_compile() {
	ant -f build/build-ecs.xml || die "compilation failed"
}

src_install() {
	java-pkg_dojar bin/*.jar
	dodoc AUTHORS  COPYING  ChangeLog  INSTALL  README
	use doc && java-pkg_dohtml -r docs/*
}
