# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.ebuild,v 1.3 2005/03/15 19:21:03 genstef Exp $

inherit nsplugins eutils

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/reader/unix/7x/${PV}/enu/AdbeRdr${PV/.}_linux_enu.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="noplugin ldap"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	!amd64? ( ldap? ( net-nds/openldap ))
	amd64? ( >=app-emulation/emul-linux-x86-gtklibs-1.2-r1 )"
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

	if use amd64 ; then
		# Work around buggy 32bit glibc on amd64, bug 77229
		dosed  "3i\export GCONV_PATH=\"/usr/lib32/gconv\"" ${INSTALLDIR}/acroread
	fi

	if use amd64 || ! use ldap ; then
		mv ${D}${INSTALLDIR}/Reader/intellinux/plug_ins/PPKLite.api \
			${D}${INSTALLDIR}/Reader/intellinux/plug_ins/PPKLite.api.disabled
	fi

	dosym ${INSTALLDIR}/acroread /usr/bin/acroread
}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die

	einfo "The browser plugin does not work on firefox 1.0.1 (yet)"
	einfo
	einfo "Asianfonts are not avaiable seperately for version 7 (yet)"
	einfo "The work around for the time being is to copy the 'Resource' directory from"
	einfo "a windows machine with acrobat reader 7 and asian font support installed."
	einfo
	einfo "The Acrobat(TM) Security Plugin will be enabled with USE=ldap, it"
	einfo "does not work with amd64 because there there is no x86 ldap-emulation"
	einfo "package available in portage."
}
