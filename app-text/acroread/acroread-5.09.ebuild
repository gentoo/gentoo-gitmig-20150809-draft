# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-5.09.ebuild,v 1.6 2004/10/25 07:32:10 usata Exp $

inherit nsplugins eutils

MY_P=linux-${PV/./}
S=${WORKDIR}
DESCRIPTION="Adobe's PDF reader"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/acrobatreader/unix/5.x/${MY_P}.tar.gz"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
IUSE="cjk"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="-* x86 ~amd64"

RESTRICT="nostrip"
DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="cjk? ( media-fonts/acroread-asianfonts )
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.2-r1 )"
PROVIDE="virtual/pdfviewer"

INSTALLDIR=/opt/Acrobat5

pkg_setup() {

	einfo
	einfo "gtk2 USE flag can cause a slowdown in Mozilla's performance"
	einfo "especially when using the acroread plugin to view a PDF file."
	einfo
}

src_compile() {

	tar -xvf LINUXRDR.TAR --no-same-owner
	tar -xvf COMMON.TAR --no-same-owner

	sed -e "s:REPLACE_ME:${INSTALLDIR}/Reader:" \
		bin/acroread.sh > acroread

	#epatch ${FILESDIR}/acroread-utf8-gentoo.diff

	# Workaround till lib symlinks change from lib64 to lib32
	# Danny van Dyk <kugelfang@gentoo.org> 2004/08/30
	if use amd64 ; then
		sed -i -e "s:^install_dir:export XLOCALEDIR=/usr/X11R6/lib32/X11/locale/\n&:1" acroread
	fi
}

src_install() {

	dodir ${INSTALLDIR}
	for i in Browsers Reader Resource
	do
		if [ -d ${i} ] ; then
			chown -R --dereference root:root ${i}
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

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die
}
