# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.12.ebuild,v 1.2 2005/06/15 21:09:42 swegener Exp $

inherit kde eutils flag-o-matic

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
SRC_URI="mirror://sourceforge/k3b/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="css dvdr encode ffmpeg flac hal kde mp3 musepack vorbis"

DEPEND="kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
	hal? ( =sys-apps/dbus-0.23*
		=sys-apps/hal-0.4* )
	media-libs/libsndfile
	media-libs/libsamplerate
	media-libs/taglib
	media-libs/musicbrainz
	>=media-sound/cdparanoia-3.9.8
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	mp3? ( media-libs/libmad )
	musepack? ( media-libs/libmpcdec )
	vorbis? ( media-libs/libvorbis )"

RDEPEND="${DEPEND}
	virtual/cdrtools
	>=app-cdr/cdrdao-1.1.7-r3
	media-sound/normalize
	dvdr? ( app-cdr/dvd+rw-tools )
	css? ( media-libs/libdvdcss )
	encode? ( media-sound/lame
		  media-sound/sox
		  media-video/transcode
		  media-video/vcdimager )"

need-kde 3.3

I18N="${PN}-i18n-${PV}"

# These are the languages and translated documentation supported by k3b for 
# version 0.11.x. If you are using this ebuild as a model for another ebuild 
# for another version of K3b, DO check whether these values are different.
# Check the {po,doc}/Makefile.am files in k3b-i18n package.
LANGS="bg br bs ca cs cy da de el en_GB es et fr ga hi is it lt mk nb nl nn pl pt pt_BR ru sr sv ta tr uk zh_CN"


MAKE_LANGS=$(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d | fmt -w 10000)
MAKE_lANGS=${MAKE_lANGS/sr/sr sr@Latn}

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/k3b/${I18N}.tar.bz2 )"
done

pkg_setup() {
	use hal && if ! built_with_use dbus qt ; then
		eerror "You are trying to compile ${CATEGORY}/${P} with the \"hal\" USE flag enabled,"
		eerror "but sys-apps/dbus is not built with Qt support."
		die
	fi
}

src_compile() {
	local _S=${S}
	local myconf="--enable-libsuffix= --with-external-libsamplerate \
			--without-resmgr --with-musicbrainz \
			$(use_with kde k3bsetup)	\
			$(use_with hal)			\
			$(use_with encode lame)		\
			$(use_with ffmpeg)		\
			$(use_with flac)		\
			$(use_with vorbis oggvorbis)	\
			$(use_with mp3 libmad)		\
			$(use_with musepack)"

	# Build process of K3B
	kde_src_compile

	# Build process of K3B-i18n, select LINGUAS elements
	S=${WORKDIR}/${I18N}
	if [ -n "${LINGUAS}" -a -d "${S}" ] ; then
		sed -i -e "s:^SUBDIRS = .*:SUBDIRS = ${MAKE_LANGS}:" ${S}/Makefile.in
		kde_src_compile
	fi
	S=${_S}
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING FAQ INSTALL KNOWNBUGS PERMISSIONS README TODO

	if [ -n "${LINGUAS}" -a -d "${WORKDIR}/${I18N}" ]; then
		cd ${WORKDIR}/${I18N}
		make DESTDIR=${D} install || die
	fi

	# install menu entry
	if use kde; then
		mv ${D}/usr/share/applnk/Settings/System/k3bsetup2.desktop ${D}/usr/share/applications
	fi
	rm -fR ${D}/usr/share/applnk/
}

pkg_postinst() {
	echo
	einfo "Make sure you have proper read/write permissions on the cdrom device(s)."
	einfo "Usually, it is sufficient to be in the cdrom or cdrw group."
	echo
}
