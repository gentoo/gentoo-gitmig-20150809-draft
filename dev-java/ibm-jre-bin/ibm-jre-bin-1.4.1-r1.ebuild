# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.1-r1.ebuild,v 1.17 2005/07/13 14:07:00 swegener Exp $

inherit java

S="${WORKDIR}/j2sdk${PV}"
DESCRIPTION="IBM Java Development Kit ${PV}"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="ppc? ( mirror://gentoo/IBMJava2-JRE-141.ppc.tgz )
	ppc64? ( mirror://gentoo/IBMJava2-JRE-141.ppc64.tgz )
	x86? ( mirror://gentoo/IBMJava2-JRE-141.tgz )"
PROVIDE="virtual/jre"
IUSE="browserplugin mozilla"
SLOT="1.4"
LICENSE="IBM-J1.4"
KEYWORDS="ppc ~x86 ppc64 -*"
DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5"
RDEPEND=""

if use ppc; then
	S=${WORKDIR}/IBMJava2-ppc-141
elif use ppc64; then
	S=${WORKDIR}/IBMJava2-ppc64-141
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
		< ${FILESDIR}/${P} \
		> ${D}/etc/env.d/java/20${P} \
		|| die "unable to install environment file"

	if use browserplugin || use mozilla; then
		local plugin="libjavaplugin_oji.so"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi
		install_mozilla_plugin /opt/${P}/bin/${plugin}
	fi

}

pkg_postinst() {
	if ! use browserplugin && use mozilla; then
		ewarn
		ewarn "The 'mozilla' useflag to enable the java browser plugin for applets"
		ewarn "has been renamed to 'browserplugin' please update your USE"
	fi
}
