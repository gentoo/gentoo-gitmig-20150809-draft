# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkvtoolnix/mkvtoolnix-4.3.0.ebuild,v 1.3 2010/10/01 23:29:03 beandog Exp $

EAPI="1"
inherit wxwidgets autotools

DESCRIPTION="Tools to create, alter, and inspect Matroska files"
HOMEPAGE="http://www.bunkus.org/videotools/mkvtoolnix"
SRC_URI="http://www.bunkus.org/videotools/mkvtoolnix/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="bzip2 debug lzo wxwidgets"

RDEPEND="
	>=dev-libs/libebml-1.0.0
	>=media-libs/libmatroska-1.0.0
	dev-libs/boost
	dev-libs/expat
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	sys-apps/file
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )
	lzo? ( dev-libs/lzo )
	wxwidgets? ( x11-libs/wxGTK:2.8 )
"
DEPEND="${RDEPEND}
	dev-ruby/rake
"

pkg_setup() {
	WX_GTK_VER="2.8"
	if use wxwidgets; then
		need-wxwidgets unicode
	fi
}

src_prepare() {
	eautoreconf
}

src_compile() {
	use wxwidgets && myconf="--with-wx-config=${WX_CONFIG}"
	econf \
		$(use_enable lzo) \
		$(use_enable bzip2 bz2) \
		$(use_enable wxwidgets) \
		$(use_enable debug) \
		--disable-qt \
		${myconf} \
		--with-boost-regex=boost_regex \
		--with-boost-filesystem=boost_filesystem \
		--with-boost-system=boost_system

	rake || die "rake failed"
}

src_install() {
	# Don't run strip while installing stuff, leave to portage the job.
	DESTDIR="${D}" rake install || die

	dodoc AUTHORS ChangeLog README TODO
	doman doc/man/*.1
}
