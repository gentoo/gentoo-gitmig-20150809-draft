# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit/jrockit-8.1.ebuild,v 1.1 2003/05/23 17:27:50 tberman Exp $

IUSE=""

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip"

inherit java

At="jrockit-8.1-j2se1.4.1-linux32.bin"
S="${WORKDIR}"
SRC_URI=""
DESCRIPTION="BEA WebLogic's J2SE Development Kit, version 8.1"
HOMEPAGE="http://commerce.bea.com/downloads/weblogic_jrockit.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="~x86"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		eerror "Please download ${At} from ${HOMEPAGE} (select the \"Linux (32 bit)\" package format of \"WebLogic JRockit 8.1\") and move it to ${DISTDIR}."
		eerror "NOTE: This download REQUIRES a fairly extensive registration process."
		die "Download ${At} and put it into ${DISTDIR}."
	fi
        unzip ${DISTDIR}/${At} *.zip
        for z in *.zip ; do
          unzip $z
          rm $z
        done
}

src_install () {
	local dirs="bin console include jre lib"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -dpR $i ${D}/opt/${P}/
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
