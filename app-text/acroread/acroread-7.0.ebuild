# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.ebuild,v 1.1 2005/03/14 21:27:05 genstef Exp $

inherit nsplugins eutils

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/reader/unix/7x/${PV}/enu/AdbeRdr${PV/.}_linux_enu.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="cjk noplugin"
RESTRICT="nostrip"

DEPEND="virtual/libc"
RDEPEND="cjk? ( media-fonts/acroread-asianfonts )"
PROVIDE="virtual/pdfviewer"

INSTALLDIR=/opt/Acrobat7

S=${WORKDIR}/AdobeReader

src_unpack() {
	unpack ${A}
	cd ${S}
	tar xf COMMON.TAR --no-same-owner
	tar xf ILINXR.TAR --no-same-owner
}

src_install() {
	local i

	cp Resource/Support/AdobeReader_KDE.desktop AdobeReader.desktop
	domenu AdobeReader.desktop
	doicon Resource/Icons/AdobeReader.png

	dodir ${INSTALLDIR}
	DIRS="Reader Resource"
	use !noplugin && DIRS="${DIRS} Browser"
	for i in ${DIRS}
	do
		if [ -d ${i} ] ; then
			chown -R --dereference root:root ${i}
			mv ${i} ${D}${INSTALLDIR}
		fi
	done

	exeinto ${INSTALLDIR}
	doexe bin/acroread || die "doexe failed"
	dodoc README LICREAD.TXT

	if ! use noplugin ; then
		dodir /opt/netscape/plugins
		dosym ${INSTALLDIR}/Browser/intellinux/nppdf.so /opt/netscape/plugins
		inst_plugin ${INSTALLDIR}/Browser/intellinux/nppdf.so
	fi

	#dynamic environment by T.Henderson@cs.ucl.ac.uk (Tristan Henderson)
	dodir /etc/env.d
	echo -e "PATH=${INSTALLDIR}\nROOTPATH=${INSTALLDIR}" > \
		${D}/etc/env.d/10acroread5

}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die
}
