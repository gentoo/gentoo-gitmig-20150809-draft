# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-pool/commons-pool-1.0.1-r1.ebuild,v 1.1 2002/11/01 18:12:07 karltk Exp $

S=${WORKDIR}/commons-pool-${PV}-src
DESCRIPTION="Jakarta component providing general purpose object pooling API"
HOMEPAGE="http://jakarta.apache.org/commons/pool.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-commons/release/commons-pool/v${PV}/commons-pool-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
		>=dev-java/ant-1.4
		>=dev-java/commons-collections-2.0
		junit? ( >=junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3
		>=dev-java/commons-collections-2.0"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
IUSE=""

src_compile() {
	echo "commons-collections.jar=`java-config --classpath=commons-collections`" > build.properties

	if [ -n "`use junit`" ] ; then
		echo "junit.jar=`java-config --classpath=junit`" >> build.properties
		ant || die "Testing Classes Failed"
	fi

	ant dist-jar || die "Compilation Failed"
	ant doc || die "Unable to create documents"
}

src_install () {
	dojar dist/commons-pool*.jar || die "Unable to install"
	dodoc README.txt
	dohtml *.html
	dohtml -r dist/docs/*
}

pkg_postinst() {
	einfo "********** Documentation can be found at **********\n
    WEB: ${HOMEPAGE}\n
    LOCAL: /usr/share/doc/commons-pool-${PV}\n
   ***************************************************"
}
