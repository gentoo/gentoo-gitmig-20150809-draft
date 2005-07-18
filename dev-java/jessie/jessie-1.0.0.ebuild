# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jessie/jessie-1.0.0.ebuild,v 1.6 2005/07/18 13:14:00 axxo Exp $

inherit java-pkg

DESCRIPTION="Free JSSE implementation"
HOMEPAGE="http://www.nongnu.org/jessie"
SRC_URI="http://syzygy.metastatic.org/jessie/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes ssl"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/gnu-classpath-0.08_rc1
	ssl? ( dev-java/gnu-crypto )"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	jikes? ( >=dev-java/jikes-1.19 )"

src_compile() {
	use jikes && export JAVAC=$(which jikes)

	use ssl && export CLASSPATH=${CLASSPATH}:$(java-pkg_getjars gnu-crypto)
	export CLASSPATH=${CLASSPATH}:/usr/share/classpath/glibj.zip

	# Must check later that this actually works
	econf --with-java-target=1.4 --disable-awt || die
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
	use doc && java-pkg_dohtml -r apidoc/*
}
