# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.3.3.ebuild,v 1.4 2007/09/28 23:58:25 dirtyepic Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils autotools wxwidgets

IUSE="flac ladspa libsamplerate mp3 unicode vorbis"

MY_P="${PN}-src-${PV}"
DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="test"

DEPEND="=x11-libs/wxGTK-2.6*
	>=app-arch/zip-2.3
	dev-libs/expat
	>=media-libs/libsndfile-1.0.0
	>=media-libs/libsoundtouch-1.3.1
	vorbis? ( >=media-libs/libvorbis-1.0 )
	mp3? ( >=media-libs/libmad-0.14.2b
		media-libs/libid3tag )
	flac? ( media-libs/flac )
	libsamplerate? ( >=media-libs/libsamplerate-0.1.2 )"
RDEPEND="${DEPEND}
	mp3? ( >=media-sound/lame-3.70 )"

S="${WORKDIR}/${MY_P}-beta"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}+flac-1.1.3.patch"

	eautoreconf || die
}

src_compile() {
	local myconf
	WX_GTK_VER="2.6"

	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi

	myconf="${myconf} --with-libsndfile=system"
	myconf="${myconf} --with-libexpat=system"
	myconf="${myconf} --with-libsoundtouch=system"

	if use libsamplerate ; then
		myconf="${myconf} --with-libsamplerate=system --without-libresample"
	else
		myconf="${myconf} --without-libsamplerate" # --with-libresample=local
	fi

	econf \
		$(use_enable unicode) \
		$(use_with ladspa) \
		$(use_with vorbis vorbis system) \
		$(use_with mp3 libmad system) \
		$(use_with mp3 id3tag system) \
		$(use_with flac flac system) \
		${myconf} || die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf "${D}"/usr/share/doc

	# Install our docs
	dodoc README.txt

	insinto /usr/share/audacity/
	newins images/AudacityLogo48x48.xpm audacity.xpm
}
