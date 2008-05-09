# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-2.2.0.ebuild,v 1.3 2008/05/09 10:03:35 yngwin Exp $

EAPI="1"
inherit eutils wxwidgets flag-o-matic qt4 autotools

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="wxwindows flac bzip2 lzo qt4 debug unicode"

DEPEND=">=dev-libs/libebml-0.7.7
	>=media-libs/libmatroska-0.8.1
	media-libs/libogg
	media-libs/libvorbis
	dev-libs/expat
	dev-libs/libpcre
	sys-libs/zlib
	wxwindows? ( =x11-libs/wxGTK-2.6* )
	flac? ( media-libs/flac )
	bzip2? ( app-arch/bzip2 )
	lzo? ( dev-libs/lzo )
	qt4? ( || ( >=x11-libs/qt-4.3.0 x11-libs/qt-gui:4 ) )"

pkg_setup() {
	WX_GTK_VER="2.6"
	if use wxwindows; then
		use unicode && need-wxwidgets unicode || need-wxwidgets ansi
	fi

	if ! built_with_use --missing true dev-libs/libpcre cxx; then
		eerror "To build ${PN} you need the C++ bindings for pcre."
		eerror "Please enable the cxx USE flag for dev-libs/libpcre"
		die "Missing PCRE C++ bindings."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	use wxwindows && myconf="--with-wx-config=${WX_CONFIG}"
	econf \
		$(use_enable lzo) \
		$(use_enable bzip2 bz2) \
		$(use_enable wxwindows wxwidgets) \
		$(use_enable debug) \
		$(use_with flac) \
		$(use_enable qt4 qt) \
		${myconf} \
		|| die "./configure died"

	# Don't run strip while installing stuff, leave to portage the job.
	emake STRIP="true" || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" STRIP="true" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml doc/mkvmerge-gui.html doc/images/*
	docinto examples
	dodoc examples/*
}
