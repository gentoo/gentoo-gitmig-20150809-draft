# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.2.03.ebuild,v 1.6 2006/03/19 11:19:27 corsair Exp $

inherit java eutils

if use x86 ; then
	JRE_DIST="IBMJava2-JRE-142.tgz"
	JRE_DIST_GENTOO="IBMJava2-JRE-142-SR3.tgz"
elif use amd64 ; then
	JRE_DIST="IBMJava2-JRE-AMD64-142.x86_64.tgz"
	JRE_DIST_GENTOO="IBMJava2-JRE-AMD64-142.x86_64-SR3.tgz"
elif use ppc ; then
	JRE_DIST="IBMJava2-JRE-142.ppc.tgz"
	JRE_DIST_GENTOO="IBMJava2-JRE-142.ppc-SR3.tgz"
elif use ppc64 ; then
	JRE_DIST="IBMJava2-JRE-142.ppc64.tgz"
	JRE_DIST_GENTOO="IBMJava2-JRE-142.ppc64-SR3.tgz"
fi

DESCRIPTION="IBM Java Development Kit"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="x86? ( IBMJava2-JRE-142-SR3.tgz )
		 amd64? ( IBMJava2-JRE-AMD64-142.x86_64-SR3.tgz )
		 ppc? ( IBMJava2-JRE-142.ppc-SR3.tgz )
		 ppc64? ( IBMJava2-JRE-142.ppc64-SR3.tgz )"

LICENSE="IBM-J1.4"
SLOT="1.4"
KEYWORDS="-* ~amd64 ppc ppc64 x86"
IUSE="X nsplugin"

DEPEND="virtual/libc
		X? ( || (
					(
						x11-libs/libXt
						x11-libs/libX11
						x11-libs/libXtst
						x11-libs/libXp
						x11-libs/libXext
						x11-libs/libSM
						x11-libs/libICE
						x11-libs/libXau
						x11-libs/libXdmcp
						x11-libs/libXi
						x11-libs/libXmu
					)
					virtual/x11
				)
			)"
RDEPEND="${DEPEND}
		 !ppc64? ( !amd64? ( sys-libs/lib-compat ) )"

PROVIDE="virtual/jre"

RESTRICT="fetch"

if use ppc; then
	S="${WORKDIR}/IBMJava2-ppc-142"
elif use ppc64; then
	S="${WORKDIR}/IBMJava2-ppc64-142"
elif use amd64; then
	S="${WORKDIR}/IBMJava2-amd64-142"
else
	S="${WORKDIR}/IBMJava2-142"
fi

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${HOMEPAGE}"
	einfo "Download: ${JRE_DIST}"
	einfo "Rename ${JRE_DIST} to ${JRE_DIST_GENTOO}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then run emerge ${PN}"
}

pkg_setup() {
	einfo "The mozilla and browserplugin useflags have been dropped from this "
	einfo "version.  If you wish to use the browser plugin then please use the"
	einfo "nsplugin useflag"
	ebeep 5
}

src_compile() { :; }

src_install() {
	# The javaws execution script is 777 why?
	chmod 0755 ${S}/jre/javaws/javaws

	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR ${S}/jre ${D}opt/${P}/

	if use nsplugin && ! use ppc && ! use amd64 && ! use ppc64; then
		local plugin="libjavaplugin_oji.so"

		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi

		install_mozilla_plugin /opt/${P}/jre/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {
	java_pkg_postinst

	if ! use X; then
		ewarn
		ewarn "You have not enabled the X useflag.  It is possible that"
		ewarn "you do not have an X server installed.  Please note that"
		ewarn "some parts of the IBM JRE require an X server to properly"
		ewarn "function.  Be careful which Java libraries you attempt to"
		ewarn "use with your installation."
		ewarn
	fi
}
