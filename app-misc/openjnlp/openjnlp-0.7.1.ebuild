# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/openjnlp/openjnlp-0.7.1.ebuild,v 1.8 2007/07/12 03:35:11 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="An open-source implementation of the JNLP"
HOMEPAGE="http://openjnlp.nanode.org/"
SRC_URI="mirror://sourceforge/openjnlp/${P/openjnlp/OpenJNLP}.tar.gz"
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~alpha ppc x86"
IUSE=""
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}/${P/openjnlp/OpenJNLP}

src_compile() { :; }

src_install() {
	java-pkg_dojar lib/*.jar

	echo "#!/bin/sh" > ${PN}
	echo '${JAVA_HOME}'/bin/java -cp `java-config --classpath=openjnlp` org.nanode.app.OpenJNLP '$*' >> ${PN}

	dodoc {History,ReadMe}.txt

	dobin ${PN}
}
