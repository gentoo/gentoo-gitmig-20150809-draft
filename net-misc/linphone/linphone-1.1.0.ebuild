# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linphone/linphone-1.1.0.ebuild,v 1.5 2006/07/07 06:49:53 mr_bones_ Exp $

inherit eutils

MY_DPV="${PV%.*}.x"

DESCRIPTION="Linphone is a SIP phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${MY_DPV}/source/${P}.tar.gz"
SLOT=1
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

IUSE="alsa gnome ipv6 xv"

DEPEND="dev-libs/glib
	dev-perl/XML-Parser
	>=net-libs/libosip-2.2.0
	>=media-libs/speex-1.1.6
	x86? 	( xv? ( dev-lang/nasm ) )
	gnome? 	( >=gnome-base/libgnome-2
		  >=gnome-base/libgnomeui-2
		  >=x11-libs/gtk+-2 )
	alsa? 	( media-libs/alsa-lib )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# fix #99083
	epatch ${FILESDIR}/${PN}-1.0.1-ipv6-include.diff
}

src_compile() {
	local withgnome

	if use gnome; then
		einfo "Building with GNOME interface."
		withgnome="yes"
	else
		withgnome="no"
	fi

	econf --enable-glib \
		--with-speex=/usr \
		--libdir=/usr/$(get_libdir)/linphone \
		--enable-gnome_ui=${withgnome} \
		`use_enable ipv6` \
		`use_enable alsa` \
		|| die "Unable to configure"

	emake || die "Unable to make"
}

src_install () {
	make DESTDIR=${D} install || die "Failed to install"

	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README
	dodoc README.arm TODO

	# don't install ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -rf ${D}/usr/include/ortp
	rm -rf ${D}/usr/share/gtk-doc/html/ortp
	rm -rf ${D}/usr/$(get_libdir)/linphone/pkgconfig
}
