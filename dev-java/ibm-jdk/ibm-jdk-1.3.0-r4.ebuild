# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.3.0-r4.ebuild,v 1.5 2002/08/01 17:26:54 karltk Exp $

At=IBMJava2-SDK-13.tgz
S=${WORKDIR}/IBMJava2-13
DESCRIPTION="IBM JDK 1.3.0"
SRC_URI=""
HOMEPAGE="http://www6.software.ibm.com/dl/dklx130/dklx130-p"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.1"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3
	virtual/jdk-1.3
	virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	unpack ${At} || die
}


src_install () {

	dodir /opt/${P}
	for i in bin include jre lib ; do
		cp -dpR $i ${D}/opt/${P}/
	done

	dodir /opt/${P}/share
	for i in demo javasrc.jar ; do
		cp -dpR $i ${D}/opt/${P}/share/
	done
	
	dohtml -a html,htm,HTML -r docs
	dodoc docs/COPYRIGHT

	# Plugin is disabled as it crashes all the time	
#	if [ "`use mozilla`" ] ; then
#		dodir /usr/lib/mozilla/plugins
#		dosym /opt/${P}/jre/bin/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
#	fi

	dodir /etc/env.d/java
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/ibm-jdk-${PV} \
		> ${D}/etc/env.d/java/20ibm-jdk-${PV}
}

src_postinst() {
	
#	if [ -e /opt/netscape/plugins ] ; then
#		ln -sf /opt/${P}/jre/bin/javaplugin.so /opt/netscape/plugins/
#		einfo "Netscape 4.x Java plugin installed"
#	fi

#	if [ "`use mozilla`" ] ; then
#		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins"
#	else
#		einfo "To install the browser plugin manually, do:"
#		einfo "ln -sf /opt/${P}/jre/bin/libjavaplugin_oji.so /usr/lib/mozilla/plugins/"
#	fi
	true
}
