# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/argouml/argouml-0.18.1.ebuild,v 1.2 2005/08/26 13:26:12 flameeyes Exp $

inherit java-pkg

DESCRIPTION="ArgoUML is a modelling tool that helps you do your design using UML."
HOMEPAGE="http://argouml.tigris.org"
SRC_URI="http://argouml.tigris.org/files/documents/4/0/${P}/ArgoUML-${PV}.tar.gz
		http://argouml.tigris.org/files/documents/4/0/${P}/ArgoUML-${PV}-modules.tar.gz
		doc? ( http://argouml.tigris.org/files/documents/4/0/${P}/argomanual-${PV}.pdf
		http://argouml.tigris.org/files/documents/4/0/${P}/quickguide-${PV}.pdf
		http://argouml.tigris.org/files/documents/4/0/${P}/cookbook-${PV}.pdf )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
RESTRICT="nomirror"
IUSE="doc"
RDEPEND=">=virtual/jre-1.3"
S=${WORKDIR}

src_compile() { :; }

src_install() {
	dodir /opt/${PN}
	cp -pPR . ${D}/opt/${PN}/lib/
	chmod -R 755 ${D}/opt/${PN}
	touch ${D}/opt/${PN}/lib/argouml.log
	chmod a+w ${D}/opt/${PN}/lib/argouml.log

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}/lib" >> ${PN}
	echo '"${JAVA_HOME}"/bin/java -jar argouml.jar' >> ${PN}
	into /opt
	dobin ${PN}

	dodoc README.txt

	if use doc ; then
		insinto /usr/share/doc/${P}
		doins ${DISTDIR}/argomanual-${PV}.pdf
		doins ${DISTDIR}/quickguide-${PV}.pdf
		doins ${DISTDIR}/cookbook-${PV}.pdf
	fi
}
