# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jext/jext-3.2_pre3.ebuild,v 1.1 2003/04/30 00:16:19 tberman Exp $

DESCRIPTION="A cool and fully featured editor in Java"
HOMEPAGE="http://www.jext.org/"
MY_PV="3.2pre3"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz
	 mirror://sourceforge/${PN}/${PN}-sources-${MY_PV}.tar.gz"
LICENSE="GPL-2 | JPython"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/jdk
	>=dev-java/ant-1.4.1
	dev-java/jython"
RDEPEND="virtual/jre
	dev-java/jython"

src_compile() {
	cd ${WORKDIR}/jext-sources-3.2pre3/src
	sed -e s:'<property name="classpath" value="" />':"<property name='classpath' value='`java-config --classpath=jython`' />": build.xml > tmp.xml
	mv tmp.xml build.xml
	ant jar javadocs -quiet > /dev/null || die
}

src_install () {
	dodir /usr/lib/jext
	cp -a ${WORKDIR}/jext-sources-3.2pre3/lib ${D}/usr/lib/jext
	exeinto /usr/bin
	newexe ${FILESDIR}/jext-gentoo.sh jext
	dohtml -A .css .gif .jpg -r ${WORKDIR}/jext-sources-3.2pre3/docs/api
}
