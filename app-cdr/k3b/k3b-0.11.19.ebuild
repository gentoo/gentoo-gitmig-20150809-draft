# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.11.19.ebuild,v 1.6 2005/04/08 09:46:54 greg_g Exp $

inherit kde eutils

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="arts dvdr encode flac kde mad oggvorbis"

DEPEND="arts? ( kde-base/arts )
	kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
	media-libs/libsamplerate
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/id3lib-3.8.0_pre2
	flac? ( <media-libs/flac-1.1.2 )
	mad? ( media-libs/libmad )
	oggvorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}
	virtual/cdrtools
	>=app-cdr/cdrdao-1.1.7-r3
	media-sound/normalize
	dvdr? ( app-cdr/dvd+rw-tools )
	encode? ( media-sound/lame
		  media-sound/sox
		  !amd64? ( <media-video/transcode-0.6.12 )
		  media-video/vcdimager )"

need-kde 3.1

I18N="${PN}-i18n-${PV%.*}"

# These are the languages and translated documentation supported by k3b for 
# version 0.11.x. If you are using this ebuild as a model for another ebuild 
# for another version of K3b, DO check whether these values are different.
# Check the {po,doc}/Makefile.am files in k3b-i18n package.
LANGS="ar bg bs ca cs da de el en_GB es et fi fo fr gl hu it ja nb nl nso pl pt pt_BR ro ru sk sl sr sv ta tr ven xh xx zh_CN zh_TW zu"
LANGS_DOC="da de es et fr pt ru sv"

MAKE_PO=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)
MAKE_DOC=$(echo "${LINGUAS} ${LANGS_DOC}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)

for X in $LANGS; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/k3b/${I18N}.tar.bz2 )"
done

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/k3b-0.11.17-noarts.patch

	make -f admin/Makefile.common || die
}

src_compile() {
	local _S=${S}
	local myconf="--enable-libsuffix= $(use_with kde k3bsetup) \
		--with-external-libsamplerate"

	# it is important to disable flac for bug #82558.
	use flac || export ac_cv_lib_FLAC_FLAC__seekable_stream_decoder_process_single="no"

	# Build process of K3B
	kde_src_compile

	# Build process of K3B-i18n, select LINGUAS elements
	S=${WORKDIR}/${I18N}
	if [ -n "${LINGUAS}" -a -d "${S}" ] ; then
		sed -i -e "s:^SUBDIRS = .*:SUBDIRS = ${MAKE_PO}:" ${S}/po/Makefile.in
		sed -i -e "s:^SUBDIRS = .*:SUBDIRS = ${MAKE_DOC}:" ${S}/doc/Makefile.in
		kde_src_compile
	fi
	S=${_S}
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ README TODO

	if [ -n "${LINGUAS}" -a -d "${WORKDIR}/${I18N}" ]; then
		cd ${WORKDIR}/${I18N}
		make DESTDIR=${D} install || die
	fi

	# install menu entry and icon
	dodir /usr/share/applications
	mv ${D}/usr/share/applnk/Multimedia/k3b.desktop ${D}/usr/share/applications
	if use kde; then
		mv ${D}/usr/share/applnk/Settings/System/k3bsetup2.desktop ${D}/usr/share/applications
	fi
	rm -fR ${D}/usr/share/applnk/
	dodir /usr/share/pixmaps
	cp ${D}/usr/share/icons/crystalsvg/32x32/apps/k3b.png ${D}/usr/share/pixmaps/
}

pkg_postinst() {
	echo
	einfo "Make sure you have proper read/write permissions on the cdrom device(s)."
	einfo "Usually, it is sufficient to be in the cdrom or cdrw group."
	echo
}
