# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre/ibm-jre-1.3.0.ebuild,v 1.1 2002/01/29 20:01:27 karltk Exp $

At=IBMJava2-JRE-13.tgz
S=${WORKDIR}/IBMJava2-13
DESCRIPTION="IBM JRE 1.3.1"
SRC_URI=""
HOMEPAGE="http://"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.1.3"
RDEPEND="$DEPEND"

PROVIDE="virtual/jre-1.3"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	unpack ${At} || die
}


src_install () {

	dodir /opt/${P}
	cp -dpR jre/* ${D}/opt/${P}/

	dohtml -a html,htm,HTML -r docs
	dodoc docs/COPYRIGHT

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/${P}/bin/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
	fi
	
	dodir /etc/env.d
	echo "PATH=/opt/${P}/bin" > /etc/env.d/20jre
	echo "JRE_HOME=/opt/${P}" >> /etc/env.d/20jre
	echo "JAVA_HOME=/opt/${P}" >> /etc/env.d/20jre
	echo "ROOTPATH=/opt/${P}/bin" >> /etc/env.d/20jre
	echo "CLASSPATH=/opt/${P}/lib/rt.jar" >> /etc/env.d/20jre
	echo "LDPATH=/opt/${P}/bin" >> /etc/env.d/20jre
}

src_postinst() {
	if [ -e /opt/netscape/plugins ] ; then
		ln -sf /opt/${P}/bin/javaplugin.so /opt/netscape/plugins/
		einfo "Netscape 4.x Java plugin installed"
	fi

	if [ "`use mozilla`" ] ; then
                einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/javaplugin_oji.so"
        else
                einfo "To install the browser plugin manually, do:"
		einfo "ln -sf /opt/${P}/bin/libjavaplugin_oji.so /usr/lib/mozilla/plugins/"
        fi

}
