# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.5.ebuild,v 1.6 2006/04/21 17:00:40 vanquirius Exp $

inherit eutils nsplugins rpm versionator

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/7x/7.0.5"
SRC_FOOT="-$(replace_version_separator 3 "-")-1.i386.rpm"
SRC_URI="nls? ( linguas_de? ( ${SRC_HEAD}/deu/AdobeReader_deu${SRC_FOOT} )
	!linguas_de? ( linguas_fr? ( ${SRC_HEAD}/fra/AdobeReader_fra${SRC_FOOT} )
	!linguas_fr? ( linguas_ja? ( ${SRC_HEAD}/jpn/AdobeReader_jpn${SRC_FOOT} )
	!linguas_ja? ( linguas_ko? ( ${SRC_HEAD}/kor/AdobeReader_kor${SRC_FOOT} )
	!linguas_ko? ( ${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT} ) ) ) ) )
	!nls? ( ${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT} )"
LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="ldap nsplugin nls"
RESTRICT="nostrip"

RDEPEND="virtual/libc
	!amd64? ( >=x11-libs/gtk+-2.0
			net-print/cups
			ldap? ( net-nds/openldap ) )
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.4.2
			>=app-emulation/emul-linux-x86-gtklibs-2.0 )"

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
			chown -R --dereference -L root:0 ${i}
			mv ${i} ${D}${INSTALLDIR}
		fi
	done

	exeinto ${INSTALLDIR}
	doexe bin/acroread || die "doexe failed"
	# The Browser_Plugin_HowTo.txt is now in a subdirectory, which
	# is named according to the language the user is using.
	# Ie. for German, it is in a DEU directory.	See bug #118015
	#dodoc Browser/${LANG_TAG}/Browser_Plugin_HowTo.txt

	if use nsplugin ; then
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
	find ${INSTALLDIR}/. -type d | xargs chmod 755 || die

	einfo "The Acrobat(TM) Security Plugin will be enabled with USE=ldap"
	einfo "The Acrobat(TM) Browser Plugin will be enabled with USE=nsplugin"
}
