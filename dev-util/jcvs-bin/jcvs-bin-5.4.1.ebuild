# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jcvs-bin/jcvs-bin-5.4.1.ebuild,v 1.5 2004/11/03 11:48:52 axxo Exp $

DESCRIPTION="Java CVS client"
HOMEPAGE="http://www.jcvs.org/"
SRC_URI="http://www.jcvs.org/download/jcvs/jcvsii-${PV}.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.3
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.3"
S="${WORKDIR}/jCVS-${PV}"

src_compile() { :; }

src_install() {
	dodir /opt/jcvs/lib
	cp -R ${S}/bin/jars/* ${D}/opt/jcvs/lib
	cp ${S}/bin/jcvsii.jar ${D}/opt/jcvs/lib

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/jcvs/lib" >> ${PN}
	echo "java -cp activation.jar:commons-logging.jar:j2ssh-common.jar:j2ssh-core.jar:jcvsii.jar:jh.jar com.ice.jcvsii.JCVS" >> ${PN}
	into /opt
	newbin ${PN} jcvs
}
