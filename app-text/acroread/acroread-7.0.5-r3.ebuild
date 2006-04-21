# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-7.0.5-r3.ebuild,v 1.3 2006/04/21 17:00:40 vanquirius Exp $

inherit eutils nsplugins rpm versionator

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/acrobat/"
SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/7x/7.0.5"
SRC_FOOT="-$(replace_version_separator 3 "-")-1.i386.rpm"
SRC_URI="nls? (
		linguas_de? ( ${SRC_HEAD}/deu/AdobeReader_deu${SRC_FOOT} )
		linguas_fr? ( ${SRC_HEAD}/fra/AdobeReader_fra${SRC_FOOT} )
		linguas_sv? ( ${SRC_HEAD}/sve/AdobeReader_sve${SRC_FOOT} )
		linguas_es? ( ${SRC_HEAD}/esp/AdobeReader_esp${SRC_FOOT} )
		linguas_pt? ( ${SRC_HEAD}/ptb/AdobeReader_ptb${SRC_FOOT} )
		linguas_no? ( ${SRC_HEAD}/nor/AdobeReader_nor${SRC_FOOT} )
		linguas_it? ( ${SRC_HEAD}/ita/AdobeReader_ita${SRC_FOOT} )
		linguas_fi? ( ${SRC_HEAD}/suo/AdobeReader_suo${SRC_FOOT} )
		linguas_nl? ( ${SRC_HEAD}/nld/AdobeReader_nld${SRC_FOOT} )
		linguas_da? ( ${SRC_HEAD}/dan/AdobeReader_dan${SRC_FOOT} )
		linguas_ja? ( ${SRC_HEAD}/jpn/AdobeReader_jpn${SRC_FOOT} )
		linguas_ko? ( ${SRC_HEAD}/kor/AdobeReader_kor${SRC_FOOT} )
		linguas_zh_CN? ( ${SRC_HEAD}/chs/AdobeReader_chs${SRC_FOOT} )
		linguas_zh_TW? ( ${SRC_HEAD}/cht/AdobeReader_cht${SRC_FOOT} )
	)
	${SRC_HEAD}/enu/AdobeReader_enu${SRC_FOOT}
	x86? ( !cups? ( mirror://gentoo/libcups.so-i386.bz2 ) )"
LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="cups ldap nsplugin nls"
RESTRICT="nostrip nomirror"

DEPEND="app-arch/tar
	sys-apps/gawk"
RDEPEND="virtual/libc
	x86? ( >=x11-libs/gtk+-2.0
			cups? ( net-print/cups )
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
	local x prefix ext myfail first_unpack curr_lang pack_dirs

	# create language packs for non-english versions in case we have LINGUAS
	if [ "${LINGUAS}" != "" ] ; then
		mkdir ${WORKDIR}/langpacks
		for x in ${A}; do
			myfail="failure unpacking ${x}"
			ext=${x##*.}
			if [ "$ext" == "rpm" ] ; then
				prefix=${x%${SRC_FOOT}}
				curr_lang=${prefix##*_}
				curr_lang_upper=`echo ${curr_lang} | /bin/gawk -F: '{ print toupper($1); }'`

				if [ ${curr_lang} != "enu" ] ; then

					einfo "Preparing Language Pack for: ${curr_lang}"

					# unpack rpm first
					cd ${WORKDIR}
					rpm_unpack ${DISTDIR}/${x} || die "${myfail}"

					# apply patches for acrobat reader startscript
					cd ${S}
					epatch ${FILESDIR}/acroread-scim.patch
					epatch ${FILESDIR}/acroread-low-startup-fontissue.patch
					cp ${FILESDIR}/acroread-langpack.patch ./
					sed -i s/###LANG###/${curr_lang}/g ./acroread-langpack.patch
					epatch ./acroread-langpack.patch
					mv bin/acroread acroread

					# tar all language specific dirs
					pack_dirs="Reader/HowTo/${curr_lang_upper}
						Reader/Legal/${curr_lang_upper}
						Reader/Messages/${curr_lang_upper}
						Reader/help/${curr_lang_upper}
						Reader/intellinux/plug_ins/Annotations/Stamps/${curr_lang_upper}
						Reader/intellinux/res/Linguistics
						Reader/intellinux/sidecars
						Resource/Linguistics
						acroread"
					tar zcf ${WORKDIR}/langpacks/${P}-${curr_lang}.tar.gz ${pack_dirs}
				fi
			fi
		done
	fi

	# wipe out all files
	x="AdobeReader_enu${SRC_FOOT}"
	cd ${WORKDIR}
	rm -rf usr

	# now unpack the english version
	if use x86 && ! use cups ; then
		unpack ${DISTDIR}/libcups.so-i386.bz2
	fi
	rpm_unpack ${DISTDIR}/${x} || die "failure unpacking ${x}"
	cd ${S}
	epatch ${FILESDIR}/acroread-scim.patch
	epatch ${FILESDIR}/acroread-low-startup-fontissue.patch

	cp ${FILESDIR}/acroread-langpack.patch ./
	sed -i s/###LANG###/enu/g ./acroread-langpack.patch
	epatch ./acroread-langpack.patch

	if [ "${LINGUAS}" != "" ] ; then
		# just tar the startscript for backswitch to english
		cd bin
		tar zcf ${WORKDIR}/langpacks/${P}-enu.tar.gz acroread
		cd ..
	fi
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

	dodir /usr/bin
	dosym ${INSTALLDIR}/acroread /usr/bin/acroread

	# install langpacks if we have LINGUAS
	if [ "${LINGUAS}" != "" ] ; then
		mkdir ${D}${INSTALLDIR}/gentoo-langpacks
		mv ${WORKDIR}/langpacks/* ${D}${INSTALLDIR}/gentoo-langpacks
	fi
}

pkg_postinst () {
	# fix wrong directory permissions (bug #25931)
	find ${INSTALLDIR}/. -type d | xargs chmod 755 || die

	einfo "The Acrobat(TM) Security Plugin will be enabled with USE=ldap"
	einfo "The Acrobat(TM) Browser Plugin will be enabled with USE=nsplugin"
}
