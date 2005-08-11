# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.0.2-r2.ebuild,v 1.6 2005/08/11 20:21:39 flameeyes Exp $

inherit nsplugins eutils rpm versionator

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_HEAD="ftp://ftp.adobe.com/pub/adobe/reader/unix/7x/7.0"
SRC_FOOT="-$(replace_version_separator 3 "-").i386.rpm"
SRC_URI="linguas_de? ( ${SRC_HEAD}/deu/AdobeReader_deu${SRC_FOOT} )
	!linguas_de? ( linguas_fr? ( ${SRC_HEAD}/fra/AdobeReader_fra${SRC_FOOT} )
	!linguas_fr? ( linguas_ja? ( ${SRC_HEAD}/jpn/AdobeReader_jpn${SRC_FOOT} )
	!linguas_ja? ( linguas_ko? ( ${SRC_HEAD}/kor/AdobeReader_kor${SRC_FOOT} )
	!linguas_ko? ( linguas_zh_CN? ( ${SRC_HEAD}/chs/AdobeReader_chs${SRC_FOOT} )
	!linguas_zh_CN? ( linguas_zh_TW? ( ${SRC_HEAD}/cht/AdobeReader_cht${SRC_FOOT} )
	!linguas_zh_TW? ( ${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT} ) ) ) ) ) )"
LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="mozilla ldap"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	!amd64? ( >=x11-libs/gtk+-2.0
			ldap? ( net-nds/openldap ) )
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.0
			>=app-emulation/emul-linux-x86-gtklibs-2.0 )"
PROVIDE="virtual/pdfviewer"

INSTALLDIR=/opt/Acrobat7

S=${WORKDIR}/usr/local/Adobe/Acrobat7.0

pkg_setup() {
	# x86 binary package, ABI=x86
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/25
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	rpm_src_unpack
	cd ${S}
	epatch ${FILESDIR}/acroread-scim.patch
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
	dodoc Browser/Browser_Plugin_HowTo.txt

	if use mozilla ; then
		exeinto /opt/netscape/plugins
		doexe Browser/intellinux/nppdf.so
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	if use amd64 ; then
		# Work around buggy 32bit glibc on amd64, bug 77229
		dosed  "3i\export GCONV_PATH=\"/usr/$(get_libdir)/gconv\"" ${INSTALLDIR}/acroread
	fi

	if ! use ldap ; then
		rm ${D}${INSTALLDIR}/Reader/intellinux/plug_ins/PPKLite.api
	fi

	dodir /usr/bin
	dosym ${INSTALLDIR}/acroread /usr/bin/acroread
}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR} -type d | xargs chmod 755 || die

	einfo "The Acrobat(TM) Security Plugin will be enabled with USE=ldap"
}
