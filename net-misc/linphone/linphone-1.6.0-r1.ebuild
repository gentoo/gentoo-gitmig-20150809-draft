# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linphone/linphone-1.6.0-r1.ebuild,v 1.1 2007/02/02 13:36:13 drizzt Exp $

MY_DPV="${PV%.*}.x"

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.9"

inherit eutils autotools

DESCRIPTION="Linphone is a SIP phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${MY_DPV}/sources/${P}.tar.gz"
SLOT=1
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="alsa gnome ilbc ipv6 novideo xv"

RDEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-2.2.0
	>=media-libs/speex-1.1.6
	x86? ( xv? ( dev-lang/nasm ) )
	gnome? ( >=gnome-base/gnome-panel-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=x11-libs/gtk+-2 )
	alsa? ( media-libs/alsa-lib )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	!novideo? ( >=media-libs/libsdl-1.2.9
		media-video/ffmpeg
		>=media-libs/libtheora-1.0_alpha7 )"
#	portaudio? ( >=media-libs/portaudio-19_pre )"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.5.1-pkgconfig.patch
	epatch "${FILESDIR}"/${P}-call.patch
	./autogen.sh
}

src_compile() {
	local withgnome myconf=""

	use gnome && withgnome="yes" || withgnome="no"
	use x86 && myconf="--enable-truespeech"

	econf \
		--libdir=/usr/$(get_libdir)/linphone \
		--enable-gnome_ui=${withgnome} \
		$(use_with ilbc) \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable !novideo video) \
		--disable-portaudio \
		${myconf} || die "Unable to configure"

	emake || die "Unable to make"
}

src_install () {
	emake DESTDIR="${D}" install || die "Failed to install"

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README
	dodoc README.arm TODO

	# don't install ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -rf "${D}"/usr/include/ortp
	rm -rf "${D}"/usr/share/gtk-doc/html/ortp
	rm -rf "${D}"/usr/$(get_libdir)/linphone/pkgconfig
}
