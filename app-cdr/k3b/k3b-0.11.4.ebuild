# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.11.4.ebuild,v 1.1 2004/02/17 14:21:39 lanius Exp $

inherit kde
need-kde 3.1

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://k3b.sourceforge.net/"
SRC_URI="mirror://sourceforge/k3b/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug dvdr kde oggvorbis mad flac encode"

DEPEND="${DEPEND}
	kde? ( >=kde-base/kdebase-3.1 )
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/id3lib-3.8.0_pre2
	flac? ( media-libs/flac )
	mad? ( >=media-sound/mad-0.14.2b )
	oggvorbis? ( media-libs/libvorbis )"
RDEPEND="${RDEPEND}
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.7-r3
	media-sound/normalize
	dvdr? ( app-cdr/dvd+rw-tools )
	encode? ( media-sound/lame
		  media-sound/sox
		  media-video/transcode
		  media-video/vcdimager )"

# i18n support will be available in following releases

#LANGS="af bg ca cs cy da de el en_GB eo es et fa fr he hu it \
#ja nb nl nn pl pt pt_BR ru se sk sl sr sv tr ven xh zh_CN zh_TW"

#I18N="${PN}-i18n-${PV%.*}"

#for pkg in ${LANGS}
#do
#	SRC_URI="${SRC_URI} linguas_${pkg}? ( mirror://sourceforge/k3b/${I18N}.tar.gz )"
#done

src_compile() {
#	local _S="${S}"

	local myconf="--enable-libsuffix="

	use debug && myconf="${myconf} --enable-debugging --enable-profiling" \
		|| myconf="${myconf} --disable-debugging --disable-profiling"
	use kde || myconf="${myconf} --without-k3bsetup"

	# Build process of K3B
	kde_src_compile

#	if [ -n "${LINGUAS}" -a -d "${WORKDIR}/${I18N}" ]; then
#		# Build process for K3B-i18n
#		S="${WORKDIR}/${I18N}"
#		echo "SUBDIRS = ${LINGUAS}" > ${S}/po/Makefile.am
#		kde_src_compile
#	fi

#	S="${_S}"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog FAQ README TODO

#	if [ -n "${LINGUAS}" -a -d "${WORKDIR}/${I18N}" ]; then
#		cd "${WORKDIR}/${I18N}"
#		make DESTDIR=${D} install || die
#	fi
}

pkg_postinst()
{
	if use kde; then
		einfo "The k3b setup program will offer to change some permissions and"
		einfo "create a user group.  These changes are not necessary.  We recommend"
		einfo "that you clear the two check boxes that 'let k3b make changes for"
		einfo "cdrecord and cdrdao' and 'let k3b make changes for the devices when"
		einfo "running k3b setup'."
		echo
	fi
	einfo "I18n tarballs are not evailable yet, due to kde 3.2 release plan."
	einfo "LINGUAS is \"disabled\" therefore."
}
