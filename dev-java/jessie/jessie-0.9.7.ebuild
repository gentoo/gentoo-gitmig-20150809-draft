# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jessie/jessie-0.9.7.ebuild,v 1.1 2004/04/01 15:45:37 karltk Exp $

inherit java-pkg

DESCRIPTION="Free JSSE implementation"
HOMEPAGE="http://www.nongnu.org/jessie"
SRC_URI="http://syzygy.metastatic.org/jessie/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes"
RDEPEND=">=dev-java/gnu-classpath-0.08_rc1"

DEPEND=">=virtual/jdk-1.3
	jikes? ( >=dev-java/jikes-1.19 )
	${RDEPEND}
	"

src_compile() {

	use jikes && export JAVAC=$(which jikes)

	export CLASSPATH=${CLASSPATH}:$(java-config -p gnu-crypto)
	export CLASSPATH=${CLASSPATH}:/usr/share/classpath/glibj.zip

	# Must check later that this actually works	
	econf --with-java-target=1.4 || die
	make || die
	if use doc ; then
		emake apidoc
	fi
}

src_install() {
	einstall || die
	rm ${D}/usr/share/*.jar
	java-pkg_dojar lib/javax-net.jar \
		lib/javax-security-cert.jar \
		lib/org-metastatic-jessie.jar
	use doc && dohtml -r apidoc/*
}

