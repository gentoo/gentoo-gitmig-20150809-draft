# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.ebuild,v 1.7 2005/03/28 15:54:53 usata Exp $

inherit nsplugins eutils

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_URI="ftp://ftp.adobe.com/pub/adobe/reader/unix/7x/${PV}/enu/AdbeRdr${PV/.}_linux_enu.tar.gz"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="noplugin ldap cjk"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	!amd64? ( ldap? ( net-nds/openldap ))
	amd64? ( >=app-emulation/emul-linux-x86-gtklibs-1.2-r1 )"
PDEPEND="cjk? ( =media-fonts/acroread-asianfonts-${PV}* )"
PROVIDE="virtual/pdfviewer"

INSTALLDIR=/opt/Acrobat7

S=${WORKDIR}/AdobeReader

# x86 binary package, ABI=x86
# Danny van Dyk <kugelfang@gentoo.org> 2005/03/25
has_multilib_profile && ABI="x86"

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
	for i in ${DIRS}
	do
		if [ -d ${i} ] ; then
			chown -R --dereference root:root ${i}
			mv ${i} ${D}${INSTALLDIR}
		fi
	done

	exeinto ${INSTALLDIR}
	doexe bin/acroread || die "doexe failed"
	dodoc README LICREAD.TXT Browser/Browser_Plugin_HowTo.txt

	if ! use noplugin ; then
		exeinto /opt/netscape/plugins
		doexe Browser/intellinux/nppdf.so
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	if use amd64 ; then
		# Work around buggy 32bit glibc on amd64, bug 77229
		dosed  "3i\export GCONV_PATH=\"/usr/lib32/gconv\"" ${INSTALLDIR}/acroread
	fi

	if use amd64 || ! use ldap ; then
		rm ${D}${INSTALLDIR}/Reader/intellinux/plug_ins/PPKLite.api
	fi

	dodir /usr/bin
	dosym ${INSTALLDIR}/acroread /usr/bin/acroread
}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die

	einfo "The Acrobat(TM) Security Plugin will be enabled with USE=ldap, it"
	einfo "does not work with amd64 because there is no x86 ldap-emulation"
	einfo "package available in portage."
}
