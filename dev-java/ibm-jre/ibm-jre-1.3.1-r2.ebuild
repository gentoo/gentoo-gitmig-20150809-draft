# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre/ibm-jre-1.3.1-r2.ebuild,v 1.4 2004/03/18 06:42:20 zx Exp $

inherit nsplugins

At=IBMJava2-JRE-131.tgz
DESCRIPTION="IBM JRE 1.3.1"
SRC_URI="${At}"
HOMEPAGE="http://www6.software.ibm.com/dl/dklx130/dklx130-p"
DEPEND=">=dev-java/java-config-0.2.5"
PROVIDE="virtual/jre-1.3.1
		virtual/java-scheme-2"
SLOT="1.3"
IUSE=""
RESTRICT="fetch"
LICENSE="IBM-ILNWP"
KEYWORDS="x86 -ppc -sparc"

S=${WORKDIR}/IBMJava2-131

pkg_nofetch() {
	die "Please download ${At} from ${HOMEPAGE}"
}

src_compile() { :; }

src_install() {

	dodir /opt/${P}
	cp -dpR jre/* ${D}/opt/${P}/

	dohtml -a html,htm,HTML -r docs
	dodoc docs/COPYRIGHT

	dodir /etc/env.d/java
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/ibm-jre-${PV} \
		> ${D}/etc/env.d/java/20ibm-jre-${PV}
}

src_postinst() {
	# Plugin as been disabled as it crashes all the time
	## inst_plugin /opt/${P}/bin/javaplugin.so 
	true
}
