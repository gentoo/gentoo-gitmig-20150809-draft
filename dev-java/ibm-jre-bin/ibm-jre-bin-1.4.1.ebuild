# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.1.ebuild,v 1.13 2004/08/04 12:52:54 axxo Exp $

inherit java nsplugins

S="${WORKDIR}/j2sdk${PV}"
DESCRIPTION="IBM Java Development Kit ${PV}"
SRC_URI="ppc?(mirror://gentoo/IBMJava2-JRE-141.ppc.tgz)
	x86?(mirror://gentoo/IBMJava2-JRE-141.tgz)"
PROVIDE="virtual/jre-1.4.1
	virtual/java-scheme-2"
IUSE=""
SLOT="1.4"
LICENSE="IBM-J1.4"
KEYWORDS="ppc ~x86"
DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5"
RDEPEND="${DEPEND}"


if use ppc; then
	S=${WORKDIR}/IBMJava2-ppc-141
else
	S=${WORKDIR}/IBMJava2-141
fi;

src_compile() {
	einfo "${PF} is a binary package, no compilation required"
}

src_install() {
	# Copy all the files to the designated directory 
	dodir /opt/${P}
	cp -dpR ${S}/jre/* ${D}/opt/${P}/

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	dodir /etc/env.d/java
	sed \
		-e "s/@P@/${P}/g" \
		-e "s/@PV@/${PV}/g" \
		-e "s/@PF@/${PF}/g" \
		< ${FILESDIR}/ibm-jre-${PV} \
		> ${D}/etc/env.d/java/20ibm-jre-${PV}
}

pkg_postinst(){
	inst_plugin /opt/${P}/bin/javaplugin.so
	true
}

pkg_prerm() {
	if [ ! -z "$(java-config -J | grep ${P})" ] ; then
		ewarn "It appears you are removing your default system VM!"
		ewarn "Please run java-config -L then java-config-S to set a new system VM!"
	fi
}
