# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/picard/picard-0.9.0_alpha14.ebuild,v 1.1 2007/08/17 10:50:20 coldwind Exp $

inherit eutils distutils

MY_P="${P/_/}"

DESCRIPTION="the next generation of tagger for MusicBrainz"
HOMEPAGE="http://musicbrainz.org/doc/PicardQt"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/users/luks/picard-qt/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="cdaudio ffmpeg nls"

RDEPEND=">=dev-lang/python-2.4
	>=dev-python/PyQt4-4.1
	>=x11-libs/qt-4.2
	>=media-libs/mutagen-1.9
	cdaudio? ( >=media-libs/libdiscid-0.1.1
		|| ( >=dev-lang/python-2.5 >=dev-python/ctypes-0.9 ) )
	ffmpeg? ( >=media-video/ffmpeg-0.4.9
		>=media-libs/libofa-0.9.2 )"

DEPEND="${RDEPEND}"

DOCS="AUTHORS.txt INSTALL.txt NEWS.txt"
S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use ffmpeg; then
		ewarn "The 'ffmpeg' USE flag is disabled. Acoustic fingerprinting and"
		ewarn "recognition will not be available!"
	fi
	if ! use cdaudio; then
		ewarn "The 'cdaudio' USE flag is disabled. CD index lookup and"
		ewarn "identification will be disabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-disable-locales.patch"
}
src_compile() {
	${python} setup.py config || die "setup.py config failed"
	if ! use ffmpeg; then
		sed -i -e "s:\(^with-avcodec\ =\ \).*:\1False:" \
			-e "s:\(^with-libofa\ =\ \).*:\1False:" build.cfg || die "sed failed"
	fi

	local myconf
	use nls || myconf="--disable-locales"
	${python} setup.py build ${myconf} || die "setup.py build failed"

}

src_install() {
	local myconf
	use nls || myconf="--disable-locales"
	distutils_src_install --disable-autoupdate --skip-build ${myconf}
}

pkg_postinst() {
	distutils_pkg_postinst
	echo
	elog "You should set the environment variable BROWSER to something like"
	elog "\"firefox '%s' &\" to let python know which browser to use."
}
