# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.2.2.ebuild,v 1.2 2004/10/31 10:53:04 eradicator Exp $

IUSE="encode flac mad oggvorbis"

MY_PV="${PV/_/-}"
MY_P="${PN}-src-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A free, crossplatform audio editor."
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# Do not unmask on amd64 without talking to eradicator
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=x11-libs/wxGTK-2.2.9
	>=app-arch/zip-2.3
	>=media-libs/id3lib-3.8.0
	media-libs/libid3tag
	>=media-libs/libsndfile-1.0.0
	>=media-libs/libsamplerate-0.0.14
	>=media-libs/ladspa-sdk-1.12
	flac? ( media-libs/flac )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )
	mad? ( >=media-sound/madplay-0.14 )
	encode? ( >=media-sound/lame-3.92 )"

DOC="LICENSE.txt README.txt audacity-1.2-help.htb"

pkg_setup() {
	if wx-config --cppflags | grep gtk2u >& /dev/null; then
		einfo "Audacity will not build if wxGTK was compiled"
		einfo "with unicode support.  If you are using a version of"
		einfo "wxGTK <= 2.4.2, you must set USE=-gtk2.  In newer versions,"
		einfo "you must set USE=-unicode."
		die "wxGTK must be re-emerged without unicode suport"
	fi
}

src_compile() {
	local myconf;

	myconf="--with-libsndfile=system --with-id3tag=system"

	# MAD support
	if use mad; then
		myconf="${myconf} --with-libmad=system"
	else
		myconf="${myconf} --with-libmad=none"
	fi

	# FLAC support
	if use flac; then
		myconf="${myconf} --with-libflac=system"
	else
		myconf="${myconf} --with-libflac=none"
	fi

	# Ogg Vorbis support
	if use oggvorbis; then
		myconf="${myconf} --with-vorbis=system"
	else
		myconf="${myconf} --with-vorbis=none"
	fi

	econf ${myconf} || die

	# parallel borks 
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Install our docs
	dodoc ${DOC}

	# Remove bad doc install
	rm -rf ${D}/share/doc

	insinto /usr/share/pixmaps
	newins images/AudacityLogo48x48.xpm audacity.xpm

	insinto /usr/share/applications
	doins ${FILESDIR}/audacity.desktop
}
