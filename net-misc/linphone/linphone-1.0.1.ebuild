# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linphone/linphone-1.0.1.ebuild,v 1.2 2005/07/14 22:02:13 stkn Exp $

MY_DPV="${PV%.*}.x"

DESCRIPTION="Linphone is a SIP phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${MY_DPV}/source/${P}.tar.gz"
SLOT=1
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

IUSE="xv ipv6 gnome alsa"

DEPEND="dev-libs/glib
	dev-perl/XML-Parser
	>=net-libs/libosip-2.2.0
	|| ( >=media-libs/speex-1.1.6
	     <media-libs/speex-1.1.0 )
	x86? 	( xv? ( dev-lang/nasm ) )
	gnome? 	( >=gnome-base/gnome-panel-2
		  >=gnome-base/libgnome-2
		  >=gnome-base/libgnomeui-2
		  >=x11-libs/gtk+-2 )
	alsa? 	( media-libs/alsa-lib )"

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
		--enable-gnome_ui=${withgnome} \
		`use_enable ipv6` \
		`use_enable alsa` \
		|| die "Unable to configure"

	emake || die "Unable to make"
}

src_install () {
	dodoc ABOUT-NLS AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README
	dodoc README.arm TODO
	make DESTDIR=${D} install || die "Failed to install"
}
