# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.5.0.03.ebuild,v 1.5 2005/08/25 01:39:22 agriffis Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java

DESCRIPTION="BEA WebLogic's J2SE Development Kit, version 5.0"
HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/5.0/jr_50.jsp"
SRC_URI="ia64? ( jrockit-25.2.0-jdk1.5.0_03-linux-ipf.bin )
	amd64? ( jrockit-25.2.0-jdk1.5.0_03-linux-x64.bin )
	x86? ( jrockit-25.2.0-jdk1.5.0_03-linux-ia32.bin )"

LICENSE="jrockit"
SLOT="1.5"
KEYWORDS="~amd64 ia64 ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"
PROVIDE="virtual/jre
	virtual/jdk"

pkg_nofetch() {
	einfo "Please download ${A} by"
	einfo "navigating from http://commerce.bea.com/index.jsp to ${HOMEPAGE}"
	einfo "then move the downloaded file to ${DISTDIR}"
}

src_unpack() {

	mkdir ${S}
	unzip ${DISTDIR}/${A} -d ${S} || die "Failed to unpack ${A}"

	cd ${S}
	for z in *.zip ; do
		unzip $z || die
		rm $z
	done
}

src_install() {
	local dirs="bin console include jre lib man"
	dodir /opt/${P}

	for i in ${dirs} ; do
		cp -dR $i ${D}/opt/${P}/ || die
	done

	newdoc README.TXT README
	newdoc "License Agreement.txt" LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst
	einfo "Please review the license agreement in /usr/doc/${P}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}
