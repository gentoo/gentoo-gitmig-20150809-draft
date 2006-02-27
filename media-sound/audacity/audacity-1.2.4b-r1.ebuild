# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacity/audacity-1.2.4b-r1.ebuild,v 1.2 2006/02/27 15:40:02 matsuu Exp $

inherit wxwidgets eutils flag-o-matic

IUSE="encode mad vorbis"

MY_P="${PN}-src-${PV}"
DESCRIPTION="Free crossplatform audio editor"
HOMEPAGE="http://audacity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="=x11-libs/wxGTK-2.4*
	>=app-arch/zip-2.3
	media-libs/libid3tag
	>=media-libs/libsndfile-1.0.0
	vorbis? ( >=media-libs/libvorbis-1.0 )
	encode? ( >=media-sound/lame-3.92 )
	mad? ( >=media-libs/libmad-0.14.2b )"

WX_GTK_VER="2.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.3-gcc41.patch # bug 113754
	epatch "${FILESDIR}"/${PN}-1.2.3-x86.patch # bug 121634
}

src_compile() {
	if built_with_use '=x11-libs/wxGTK-2.4*' gtk2 ; then
		need-wxwidgets gtk2
	else
		need-wxwidgets gtk
	fi

	filter-flags -fPIC

	econf \
		$(use_with mad libmad system) \
		$(use_with vorbis vorbis system) \
		--with-id3tag=system \
		--with-libsndfile=system || die

	# parallel borks
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# Remove bad doc install
	rm -rf ${D}/usr/share/doc

	# Install our docs
	dodoc README.txt audacity-1.2-help.htb

	insinto /usr/share/icons/hicolor/48x48/apps
	newins images/AudacityLogo48x48.xpm audacity.xpm

	make_desktop_entry audacity Audacity audacity
}
