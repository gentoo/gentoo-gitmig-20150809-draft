# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-jaf/gnu-jaf-1.0-r1.ebuild,v 1.3 2006/05/01 11:58:19 corsair Exp $

inherit java-pkg

DESCRIPTION="GNU JAF: JavaBeans Activation Framework"
HOMEPAGE="http://www.gnu.org/software/classpathx/jaf/jaf.html"
SRC_URI="http://ftp.gnu.org/gnu/classpathx/activation-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/activation-${PV}

src_compile() {
	econf || die "configure failed"
	make || die "make failed"

	if use doc; then
		make javadoc || die "failed to create javadoc"
	fi
}

src_install() {
	java-pkg_dojar activation.jar
	dodoc AUTHORS ChangeLog
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc source/*
}
