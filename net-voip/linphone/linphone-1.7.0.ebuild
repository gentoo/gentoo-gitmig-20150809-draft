# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/linphone/linphone-1.7.0.ebuild,v 1.1 2007/04/14 09:42:42 genstef Exp $

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.9"

inherit eutils autotools

MY_DPV="${PV%.*}.x"

DESCRIPTION="Linphone is a SIP phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${MY_DPV}/sources/${P}.tar.gz"
SLOT=1
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="alsa console ilbc ipv6 novideo xv"

RDEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-2.2.0
	>=media-libs/speex-1.1.12
	x86? ( xv? ( dev-lang/nasm ) )
	>=x11-libs/gtk+-2
	gnome-base/libglade
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

	epatch "${FILESDIR}"/linphone-1.6.0-call.patch
	sed -i -e "s:wall_werror=yes:wall_werror=no:" mediastreamer2/config*

	./autogen.sh
}

src_compile() {
	local withconsole myconf=""

	use console && withconsole="yes" || withconsole="no"
	use x86 && myconf="--enable-truespeech"

	econf \
		--libdir=/usr/$(get_libdir)/linphone \
		--enable-console_ui=${withconsole} \
		--enable-gtk_ui=yes \
		$(use_with ilbc) \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable !novideo video) \
		--disable-portaudio \
		${myconf} || die "Unable to configure"
		#$(use_enable portaudio) \

	emake || die "Unable to make"
}

src_install () {
	emake DESTDIR=${D} install || die "Failed to install"

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README
	dodoc README.arm TODO

	# don't install ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -rf ${D}/usr/include/ortp
	rm -rf ${D}/usr/share/gtk-doc/html/ortp
	rm -rf ${D}/usr/$(get_libdir)/linphone/pkgconfig
	rm -rf ${D}/ortp
}
