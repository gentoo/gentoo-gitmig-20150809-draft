# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-5.0.ebuild,v 1.2 2005/02/13 02:40:53 vapier Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java

DESCRIPTION="BEA WebLogic's J2SE Development Kit, version 5.0"
HOMEPAGE="http://commerce.bea.com/downloads/weblogicjrockit/5.0/jr_50.jsp"
SRC_URI="ia64? ( jrockit-jdk1.5.0-linux-ipf.bin )
	x86? ( jrockit-jdk1.5.0-linux-ia32.bin )"

LICENSE="jrockit"
SLOT="1.5"
KEYWORDS="~ia64 ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"
PROVIDE="virtual/jre-1.5
	virtual/jdk-1.5
	virtual/java-scheme-2"

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {

	mkdir ${S}
	unzip ${DISTDIR}/${A} -d ${S} || die "Failed to unpack ${A}"

	cd ${S}
	for z in *.zip ; do
		unzip $z
		rm $z
	done
}

src_install () {
	local dirs="bin console include jre lib"
	dodir /opt/${P}

	for i in ${dirs} ; do
		cp -dR $i ${D}/opt/${P}/
	done

	newdoc README.TXT README
	newdoc "License Agreement.txt" LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	einfo "Please review the license agreement in /usr/doc/${P}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}
