# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.2.ebuild,v 1.17 2006/07/03 13:23:32 betelgeuse Exp $

inherit java

S="${WORKDIR}/j2sdk${PV}"
DESCRIPTION="IBM Java Development Kit ${PV}"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="ppc? ( IBMJava2-JRE-142.ppc.tgz )
	ppc64? ( IBMJava2-JRE-142.ppc64.tgz )
	x86? ( IBMJava2-JRE-142.tgz )"
PROVIDE="virtual/jre"
IUSE="browserplugin nsplugin mozilla"
SLOT="1.4"
LICENSE="IBM-J1.4"
KEYWORDS="ppc ~x86 ppc64 -*"
RESTRICT=fetch

DEPEND=""
RDEPEND=""

if use ppc; then
	S=${WORKDIR}/IBMJava2-ppc-142
elif use ppc64; then
	S=${WORKDIR}/IBMJava2-ppc64-142
else
	S=${WORKDIR}/IBMJava2-142
fi;

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${HOMEPAGE}"
	einfo "Download: ${A}"
	einfo "Place the file in: ${DISTDIR}"
	einfo "Rerun emerge"
}


src_compile() {
	einfo "${PF} is a binary package, no compilation required"
}

src_install() {
	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR ${S}/jre/* ${D}/opt/${P}/

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

	if ! use ppc && ! use ppc64; then
		if use nsplugin ||       # global useflag for netscape-compat plugins
		   use browserplugin ||  # deprecated but honor for now
		   use mozilla; then     # wrong but used to honor it
			local plugin="libjavaplugin_oji.so"
			if has_version '>=sys-devel/gcc-3' ; then
				plugin="libjavaplugin_ojigcc3.so"
			fi
			install_mozilla_plugin /opt/${P}/bin/${plugin}
		fi
	fi
}

pkg_postinst() {
	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation.  Please"
		ewarn "update your USE to include 'nsplugin'."
	fi
}
