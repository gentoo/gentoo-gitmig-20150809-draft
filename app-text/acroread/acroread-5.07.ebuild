# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.07.ebuild,v 1.2 2003/06/25 21:53:20 aliz Exp $

inherit nsplugins eutils

MY_P=linux-${PV/./}
S=${WORKDIR}
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/${MY_P}.tar.gz"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
IUSE=""

SLOT="0"
LICENSE="Adobe"
KEYWORDS="-* x86"

RESTRICT="nostrip"
DEPEND="virtual/glibc
	>=sys-apps/sed-4"
INSTALLDIR=/opt/Acrobat5

src_compile() {
	
	tar -xvf LINUXRDR.TAR --no-same-owner
	tar -xvf COMMON.TAR --no-same-owner

	sed -e "s:REPLACE_ME:${INSTALLDIR}/Reader:" \
		bin/acroread.sh > acroread
	
	epatch ${FILESDIR}/acroread-utf8-gentoo.diff
}

src_install() {
	
	dodir ${INSTALLDIR}
	for i in Browsers Reader Resource
	do
		if [ -d ${i} ] ; then
			chown -R --dereference root.root ${i}
			cp -Rd ${i} ${D}${INSTALLDIR}
		fi
	done
	
	sed -i \
		-e "s:\$PROG =.*:\$PROG = '${INSTALLDIR}/acroread.real':" \
		acroread || die "sed acroread failed"
	
	exeinto ${INSTALLDIR}
	doexe acroread
	dodoc README LICREAD.TXT
	dodir /opt/netscape/plugins
	dosym ${INSTALLDIR}/Browsers/intellinux/nppdf.so /opt/netscape/plugins
	
	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10acroread5

	inst_plugin ${INSTALLDIR}/Browsers/intellinux/nppdf.so
}
