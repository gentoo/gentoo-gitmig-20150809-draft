# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre/ibm-jre-1.4.1-r2.ebuild,v 1.3 2004/03/22 19:50:36 dholm Exp $

inherit nsplugins

case ${ARCH} in
x86)
	S="${WORKDIR}/IBMJava2-141"
	;;
ppc)
	S="${WORKDIR}/IBMJava2-ppc-141"
	;;
esac
DESCRIPTION="IBM JRE 1.4.1"
SRC_URI="x86? ( IBMJava2-JRE-141.tgz )
	ppc? ( IBMJava2-JRE-141.ppc.tgz )"
HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"
RESTRICT="fetch"
DEPEND="virtual/glibc
	  >=dev-java/java-config-0.2.5"
RDEPEND="${DEPEND}"
PROVIDE="virtual/jre-1.4.1
		 virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
IUSE=""
SLOT="1.4"
KEYWORDS="x86 ppc -sparc -alpha"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	case ${ARCH} in
	x86)
		einfo "and download IBMJava2-JRE-141.tgz (for the xSeries)"
		;;
	ppc)
		einfo "and download IBMJava2-JRE-141.ppc.tgz (for the pSeries)"
		;;
	esac
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
