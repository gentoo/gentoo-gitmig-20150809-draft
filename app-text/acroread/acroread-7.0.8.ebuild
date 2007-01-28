# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.8.ebuild,v 1.9 2007/01/28 06:50:37 genone Exp $

inherit eutils nsplugins

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
IUSE="cups ldap nsplugin nls"

SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/7x/${PV}"
SRC_FOOT="-${PV}-1.i386.tar.gz"
LINS=("de" "fr" "sv" "es" "pt" "nb" "it" "fi" "nl" "da" "ja" "ko" "zh_CN"
	"zh_TW")
SRCS=("deu" "fra" "sve" "esp" "ptb" "nor" "ita" "suo" "nld" "dan" "jpn" "kor"
	"chs" "cht")

SRC_URI="nls? ( "
for ((i=0;i<${#LINS[@]};i++)) do
	IUSE="${IUSE} linguas_${LINS[$i]}"
	SRC_URI="${SRC_URI} linguas_${LINS[$i]}? ( ${SRC_HEAD}/${SRCS[$i]}/AdobeReader_${SRCS[$i]}${SRC_FOOT} ) !linguas_${LINS[$i]}? ("
	[ "$[ ${#LINS[@]} - 1 ]" -eq "${i}" ] && \
		SRC_URI="${SRC_URI} ${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT}"
	SRC_END="${SRC_END} )"
done
SRC_URI="${SRC_URI}${SRC_END} )
	!nls? ( ${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT} )
	x86? ( !cups? ( mirror://gentoo/libcups.so-i386.bz2 ) )"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* amd64 x86"
RESTRICT="strip mirror"

RDEPEND="x86? ( >=x11-libs/gtk+-2.0
			cups? ( net-print/cups )
			ldap? ( net-nds/openldap ) )
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.4.2
			>=app-emulation/emul-linux-x86-gtklibs-2.0 )"
QA_TEXTRELS_x86="opt/Acrobat7/Reader/intellinux/lib/libCoolType.so.5.01
	opt/Acrobat7/Reader/intellinux/lib/libcrypto.so.0.9.6
	opt/Acrobat7/Reader/intellinux/lib/libJP2K.so
	opt/Acrobat7/Reader/intellinux/lib/libAXSLE.so
	opt/Acrobat7/Reader/intellinux/lib/librt3d.so
	opt/Acrobat7/Reader/intellinux/SPPlugins/ADMPlugin.apl
	opt/Acrobat7/Reader/intellinux/plug_ins3d/tesselate.x3d
	opt/Acrobat7/Reader/intellinux/plug_ins3d/drvSOFT.x3d
	opt/Acrobat7/Reader/intellinux/plug_ins3d/3difr.x3d
	opt/Acrobat7/Reader/intellinux/plug_ins3d/drvOpenGL.x3d
	opt/Acrobat7/Reader/intellinux/plug_ins3d/2d.x3d
	opt/Acrobat7/Reader/intellinux/plug_ins/checkers.api
	opt/Acrobat7/Reader/intellinux/plug_ins/EFS.api
	opt/Acrobat7/Reader/intellinux/plug_ins/MakeAccessible.api
	opt/Acrobat7/Reader/intellinux/plug_ins/DigSig.api
	opt/Acrobat7/Reader/intellinux/plug_ins/wwwlink.api
	opt/Acrobat7/Reader/intellinux/plug_ins/SaveAsRTF.api
	opt/Acrobat7/Reader/intellinux/plug_ins/PPKLite.api
	opt/Acrobat7/Reader/intellinux/plug_ins/ewh.api
	opt/Acrobat7/Reader/intellinux/plug_ins/PDDom.api
	opt/Acrobat7/Reader/intellinux/plug_ins/SOAP.api
	opt/Acrobat7/Reader/intellinux/plug_ins/SendMail.api
	opt/Acrobat7/Reader/intellinux/plug_ins/Annots.api
	opt/Acrobat7/Reader/intellinux/plug_ins/SearchFind.api
	opt/Acrobat7/Reader/intellinux/plug_ins/Spelling.api
	opt/Acrobat7/Reader/intellinux/plug_ins/Accessibility.api
	opt/Acrobat7/Reader/intellinux/plug_ins/EScript.api
	opt/Acrobat7/Reader/intellinux/plug_ins/AcroForm.api
	opt/netscape/plugins/nppdf.so"

INSTALLDIR=/opt/Acrobat7

S=${WORKDIR}/AdobeReader

pkg_setup() {
	# x86 binary package, ABI=x86
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/25
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	tar xf ILINXR.TAR
	tar xf COMMON.TAR
	epatch ${FILESDIR}/acroread-scim.patch
	epatch ${FILESDIR}/acroread-low-startup-fontissue.patch
	epatch ${FILESDIR}/acroread-expr.patch
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
	dodoc Browser/HowTo/*/Browser_Plugin_HowTo.txt

	if use nsplugin ; then
		exeinto /opt/netscape/plugins
		doexe Browser/intellinux/nppdf.so
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	if ! use ldap ; then
		rm ${D}${INSTALLDIR}/Reader/intellinux/plug_ins/PPKLite.api
	fi

	# libcups is needed for printing support (bug 118417)
	if use x86 && ! use cups ; then
		mv ${WORKDIR}/libcups.so-i386 ${WORKDIR}/libcups.so.2
		exeinto ${INSTALLDIR}/Reader/intellinux/lib
		doexe ${WORKDIR}/libcups.so.2
		dosym libcups.so.2 ${INSTALLDIR}/Reader/intellinux/lib/libcups.so
	fi

	dodir /opt/bin
	dosym ${INSTALLDIR}/acroread /opt/bin/acroread

	# fix wrong directory permissions (bug #25931)
	find ${D}${INSTALLDIR}/. -type d | xargs chmod 755 || die
}

pkg_postinst () {
	elog "The Acrobat(TM) Security Plugin can be enabled with USE=ldap"
	elog "The Acrobat(TM) Browser Plugin can be enabled with USE=nsplugin"
}
