# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre/ibm-jre-1.4.1-r2.ebuild,v 1.1 2004/01/09 09:24:34 karltk Exp $

inherit nsplugins

S="${WORKDIR}/IBMJava2-141"
DESCRIPTION="IBM JRE 1.4.1"
SRC_URI="IBMJava2-JRE-141.tgz"
HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"
RESTRICT="fetch"
IUSE=""
DEPEND="virtual/glibc
	  >=dev-java/java-config-0.2.5"
RDEPEND="${DEPEND}"
PROVIDE="virtual/jre-1.4.1
		 virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="1.4"
KEYWORDS="x86 -ppc -sparc -alpha"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	einfo "and download ${SRC_URI} (for the xSeries)"
	einfo "Just save it in ${DISTDIR}"
}

src_install () {
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
	inst_plugin /opt/${P}/bin/javaplugin.so
	true
}
