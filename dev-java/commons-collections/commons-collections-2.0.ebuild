# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-collections/commons-collections-2.0.ebuild,v 1.1 2002/10/31 20:38:08 karltk Exp $

S=${WORKDIR}/commons-collections-${PV}-src
DESCRIPTION="Jakarta-Commons Collections Component"
HOMEPAGE="http://jakarta.apache.org/commons/collections.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/commons-collections/v${PV}/commons-collections-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=ant-1.4"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
IUSE=""

src_compile() {
	ant dist-jar || die "Compilation Failed"
	ant doc || die "Unable to create documents"
}

src_install () {
	dojar dist/commons-collections*.jar || die "Unable to Install"
	dodir /usr/share/doc/${P}
	dohtml dist/*.html
	dohtml -r dist/docs/*
}

pkg_postinst() {
	einfo "********** Documentation can be found at *********\n
    http://jakarta.apache.org/commons/beanutils.html\n
   **************************************************"
}
