# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.9.4a-r1.ebuild,v 1.7 2007/08/13 17:19:09 philantrop Exp $

inherit kde eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="KMPlayer is a Video player plugin for Konqueror and basic MPlayer/Xine/ffmpeg/ffserver/VDR frontend for KDE."
HOMEPAGE="http://kmplayer.kde.org/"
SRC_URI="http://kmplayer.kde.org/pkgs/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="gstreamer mplayer xine cairo"

RDEPEND="mplayer? ( || ( media-video/mplayer media-video/mplayer-bin ) )
	xine? ( >=media-libs/xine-lib-1.1.1 )
	gstreamer? ( || ( =media-libs/gst-plugins-base-0.10* =media-libs/gst-plugins-0.8* ) )
	cairo? ( x11-libs/cairo )"

DEPEND="x11-libs/libXv
	xine? ( >=media-libs/xine-lib-1.1.1 )
	gstreamer? ( || ( =media-libs/gst-plugins-base-0.10* =media-libs/gst-plugins-0.8* ) )
	cairo? ( x11-libs/cairo )"

LANGS="ar br bs ca cs cy da de el en_GB es et fi fr ga gl he hi hu is it ja ka
lt mt nb nl pa pl pt_BR pt ro ru rw sk sr@Latn sr sv ta tr uk zh_CN"

LANGS_DOC="da de en es et fr it nl pt ru sv"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.5

PATCHES="${FILESDIR}/kmplayer-0.9.4a-vop2vf.patch"

pkg_setup() {
	if ! use mplayer && ! use xine && ! use gstreamer && ! use cairo; then
		echo
		ewarn "Neither the mplayer, xine, gstreamer or cairo use flags have"
		ewarn "been set. One of them is required. From them, mplayer can be"
		ewarn "installed afterwards; however, xine and gstreamer will require"
		ewarn "you to recompile kmplayer."
	fi
}

src_unpack() {
	kde_src_unpack

	if use mplayer && use amd64 && ! has_version media-video/mplayer; then
		elog 'NOTICE: You have mplayer-bin installed; you will need to configure'
		elog 'NOTICE: kmplayer to use it from within the application.'
	fi

	cd "${WORKDIR}/${MY_P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done

	MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
	[[ -n ${MAKE_DOC} ]] && [[ -n ${DOC_DIR_SUFFIX} ]] && MAKE_DOC=$(echo "${MAKE_DOC}" | tr '\n' ' ') && MAKE_DOC="${MAKE_DOC// /${DOC_DIR_SUFFIX} }"
	sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC}:" \
		"${KDE_S}/doc/Makefile.am" || die "sed for locale failed"

	rm -f "${S}/configure"
}

src_compile(){
	local myconf="$(use_with gstreamer) $(use_with xine) $(use_with cairo)"
	kde_src_compile
}

src_install() {
	kde_src_install

	# Remove this, as kdelibs 3.5.4 provides it
	rm -f "${D}/usr/share/mimelnk/application/x-mplayer2.desktop"
}
