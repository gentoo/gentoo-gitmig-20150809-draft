# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/argouml/argouml-0.14.ebuild,v 1.2 2004/03/18 13:43:08 dholm Exp $

inherit java-pkg

DESCRIPTION="ArgoUML is a modelling tool that helps you do your design using UML."
HOMEPAGE="http://argouml.tigris.org"
SRC_URI="http://argouml.tigris.org/files/documents/4/0/$PN-$PV/ArgoUML-${PV}.tar.gz
		http://argouml.tigris.org/files/documents/4/0/${P}/ArgoUML-${PV}-modules.tar.gz
		doc? ( http://argouml.tigris.org/files/documents/4/8727/argomanual.pdf
		http://argouml.tigris.org/files/documents/4/0/argouml-${PV}/quickguide-${PV}.pdf
		http://argouml.tigris.org/files/documents/4/0/argouml-${PV}/cookbook-${PV}.pdf )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
RESTRICT="nomirror"
IUSE="doc"
RDEPEND=">=virtual/jre-1.2*"
S=${WORKDIR}

src_compile() { :; }

src_install() {
	dodir /opt/${PN}
	cp -a . ${D}/opt/${PN}/lib/
	chmod -R 755 ${D}/opt/${PN}
	touch ${D}/opt/${PN}/argouml.log
	chmod a+w ${D}/opt/${PN}/argouml.log

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}/lib" >> ${PN}
	echo '"${JAVA_HOME}"/bin/java -jar argouml.jar' >> ${PN}
	into /opt
	dobin ${PN}

	dodoc README.txt

	if [ `use doc` ] ; then
		insinto /usr/share/doc/${P}
		doins ${DISTDIR}/argomanual.pdf
		doins ${DISTDIR}/quickguide-${PV}.pdf
		doins ${DISTDIR}/cookbook-${PV}.pdf
	fi
}
