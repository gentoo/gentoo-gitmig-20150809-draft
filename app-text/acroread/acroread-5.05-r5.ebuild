# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.05-r5.ebuild,v 1.2 2002/07/12 17:04:52 seemant Exp $

MY_P=linux-${PV/./}
S=${WORKDIR}
DESCRIPTION="Adobe's PDF reader"
SRC_URI=""
HOMEPAGE="http://www.adobe.com/products/acrobat/"

DEPEND="virtual/glibc"
RDEPEND=">=app-text/xpdf-1.01"

LICENSE="Adobe"

SLOT="0"
KEYWORDS="x86"

INSTALLDIR=/opt/Acrobat5

pkg_setup() {

	ewarn "Acroread has a MAJOR security flaw, and will thus not be"
	ewarn "installed.  Rather, xpdf is the recommended application"
	ewarn "to read pdf documents."
	ewarn "If you are attempting to upgrade, please unmerge"
	ewarn "this package immediately. For further details, please consult"
	ewarn "http://online.securityfocus.com/archive/1/278984"
}

# This package will be disabled until Adobe sorts out its security issues
# with it.  Please see ChangeLog for a link to the securityfocus analysis of
# the security hazards.

#src_compile () {
#	
#	tar xvf LINUXRDR.TAR
#	tar xvf COMMON.TAR
#
#	sed -e "s:REPLACE_ME:${INSTALLDIR}/Reader:" \
#		bin/acroread.sh > acroread
#}
#
#src_install () {
#	
#	dodir ${INSTALLDIR}
#	for i in Browsers Reader Resource
#	do
#		chown -R root.root ${i}
#		cp -a ${i} ${D}${INSTALLDIR}
#	done
#	
#	exeinto ${INSTALLDIR}
#	doexe acroread
#	dodoc README LICREAD.TXT MANIFEST
#	dodir /opt/netscape/plugins
#	dosym ${INSTALLDIR}/Browsers/intellinux/nppdf.so /opt/netscape/plugins
#	
#	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
#	dodir /etc/env.d
#	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
#		${D}/etc/env.d/10acroread5
#
#	#mozilla compatibility contributed by m3thos@netcabo.pt(Miguel Sousa Filipe)
#	use mozilla && ( \
#		dodir /usr/lib/mozilla/plugins
#		dosym \
#			${INSTALLDIR}/Browsers/intellinux/nppdf.so \
#				/usr/lib/mozilla/plugins/nppdf.so
#	)
#}
