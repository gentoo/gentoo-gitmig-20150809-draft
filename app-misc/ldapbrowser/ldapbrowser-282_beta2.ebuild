# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jo Ryden <jo@our-own.net>

A="Browser282b2.tar.gz"
S=${WORKDIR}/ldapbrowser
DESCRIPTION="Easy management of LDAP directories"
SRC_URI="http://www-unix.mcs.anl.gov/%7Egawor/ldapcommon/bin/Browser282b2.tar.gz"
HOMEPAGE="http://www-unix.mcs.anl.gov/~gawor/ldap/"

RDEPEND="x11-base/xfree virtual/jre"

src_unpack() {
#	if [ ! -f ${DISTDIR}/${ARCHIVE} ]; then
#		die "Please download ${At} from ${HOMEPAGE} to ${DISTDIR} and re-run emerge"
#	fi
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PV}-gentoo.diff
}

src_install() {

	local dirs="lib templates"
	dodir /opt/${P}

	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	cp -a lbe.jar attributes.config ${D}/opt/${P}/
	dobin lbe.sh
	dosym lbe.sh /usr/bin/ldapbrowser
	dodoc CHANGES.TXT LICENSE.ICONS
	dohtml faq.html readme.html relnotes.html help/*

}

pkg_postinst() {
	echo
	echo " ---------------------------------------------------------------"
	echo "| *** DON'T FORGET TO ADD THE JAVA EXECUTABLE TO YOUR PATH ***  |"
	echo "| ***              OR SET \$JAVA_HOME                       ***  |"
	echo " ---------------------------------------------------------------"
	echo
}




