# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/fldigi/fldigi-3.12.5.ebuild,v 1.2 2010/05/24 11:46:24 tomjbe Exp $

EAPI=2

inherit eutils versionator

MY_DOC_PN=${PN}-$(get_version_component_range 1-2)

DESCRIPTION="Sound card based multimode software modem for Amateur Radio use"
HOMEPAGE="http://www.w1hkj.com/Fldigi.html"
SRC_URI="http://www.w1hkj.com/${PN}-distro/${P}.tar.gz
	doc? ( http://www.w1hkj.com/${PN}-distro/${MY_DOC_PN}.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc hamlib nls portaudio pulseaudio sndfile xmlrpc"

RDEPEND="|| ( >=x11-libs/fltk-1.1.9:1.1[threads] <x11-libs/fltk-1.1.9:1.1 )
	media-libs/libsamplerate
	media-libs/libpng
	x11-misc/xdg-utils
	hamlib? ( media-libs/hamlib )
	portaudio? ( >=media-libs/portaudio-19_pre20071207 )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( >=media-libs/libsndfile-1.0.10 )
	xmlrpc? ( || ( >=dev-libs/xmlrpc-c-1.18.02[abyss] <dev-libs/xmlrpc-c-1.18.02 )
		dev-perl/RPC-XML
		dev-perl/Term-ReadLine-Perl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	econf $(use_with sndfile) \
		$(use_with portaudio) \
		$(use_with hamlib) \
		$(use_enable nls) \
		$(use_with pulseaudio) \
		$(use_with xmlrpc) \
		--without-asciidoc
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README  || die "dodoc failed"
	if use doc ; then
		dodoc "${DISTDIR}"/${MY_DOC_PN}.pdf || die "dodoc failed"
	fi
}
