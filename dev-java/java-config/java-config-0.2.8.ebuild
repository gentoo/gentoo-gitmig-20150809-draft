# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-config/java-config-0.2.8.ebuild,v 1.2 2003/03/22 20:21:53 strider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change the Java Virtual Machine being used"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"
DEPEND=""
RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

src_install () {
	dobin ${FILESDIR}/${PV}/java-config
	doman ${FILESDIR}/${PV}/java-config.1

 	insinto /etc/env.d
 	doins ${FILESDIR}/${PV}/30java-finalclasspath
}
