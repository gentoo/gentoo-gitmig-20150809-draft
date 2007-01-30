# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linphone/linphone-1.3.5.ebuild,v 1.12 2007/01/30 15:12:44 drizzt Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit eutils autotools

MY_DPV="${PV%.*}.x"

DESCRIPTION="Linphone is a SIP phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${MY_DPV}/source/${P}.tar.gz
	ilbc? (	http://simon.morlat.free.fr/download/${MY_DPV}/source/plugins/${PN}-plugin-ilbc-1.2.0.tar.gz )"
SLOT=1
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

IUSE="alsa gnome ilbc ipv6 xv"
# truespeech does not build

RDEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-2.2.0
	>=media-libs/speex-1.1.12
	x86? ( xv? ( dev-lang/nasm ) )
	gnome? ( >=gnome-base/gnome-panel-2
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=x11-libs/gtk+-2 )
	alsa? ( media-libs/alsa-lib )
	ilbc? ( dev-libs/ilbc-rfc3951 )"

DEPEND="${RDEPEND}"

S_ILBC="${WORKDIR}/${PN}-plugin-ilbc-1.2.0"

src_unpack() {
	unpack ${A}
	grep -Rl --null " \-Werror" . | xargs -0 sed -i "s: -Werror::"

	cd "${S}"
	# fix #99083
	epatch "${FILESDIR}"/${PN}-1.0.1-ipv6-include.diff
	# fix #132824
	epatch "${FILESDIR}"/${P}-docs.diff

	if use ilbc; then
		cd "${S_ILBC}"
		# add -fPIC and custom cflags to ilbc makefile
		epatch "${FILESDIR}"/ilbc-1.2.0-makefile.diff
		cd "${S}"
	fi
	./autogen.sh
}

src_compile() {
	local withgnome myconf=""

	if use gnome; then
		einfo "Building with GNOME interface."
		withgnome="yes"
	else
		withgnome="no"
	fi

#	use x86 && use truespeech && \
#		myconf="--enable-truespeech"

	econf \
		--enable-glib \
		--with-speex=/usr \
		--libdir=/usr/$(get_libdir)/linphone \
		--enable-gnome_ui=${withgnome} \
		`use_enable ipv6` \
		`use_enable alsa` \
		${myconf} || die "Unable to configure"

	emake || die "Unable to make"

	if use ilbc; then
		emake LINPHONE_SOURCE="${S}" \
		PLUGINS_INSTALL_PATH=/usr/$(get_libdir)/linphone/plugins/mediastreamer \
		-C "${S_ILBC}" || die
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "Failed to install"

	if use ilbc; then
		emake LINPHONE_SOURCE="${S}" \
		PLUGINS_INSTALL_PATH=/usr/$(get_libdir)/linphone/plugins/mediastreamer \
		DESTDIR="${D}" -C "${S_ILBC}" install || die
	fi

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README
	dodoc README.arm TODO

	# don't install ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -rf "${D}"/usr/include/ortp
	rm -rf "${D}"/usr/share/gtk-doc/html/ortp
	rm -rf "${D}"/usr/$(get_libdir)/linphone/pkgconfig
}
