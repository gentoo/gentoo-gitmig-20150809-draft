# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minisip/minisip-0.7.0.ebuild,v 1.1 2005/06/02 01:25:39 gustavoz Exp $

inherit eutils

IUSE="alsa gtk"
DESCRIPTION="Minisip is a SIP User Agent"
HOMEPAGE="http://www.minisip.org/"
SRC_URI="http://www.minisip.org/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-libs/openssl-0.9.6d
		~net-misc/libmutil-0.3.0
		~net-misc/libmnetutil-0.3.0
		~net-misc/libmikey-0.4.0
		~net-misc/libmsip-0.3.0
		alsa? ( >=media-libs/alsa-lib-1 )
		gtk? ( >=dev-cpp/libglademm-2.0 )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-no-qtgui.patch
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable gtk) \
		$(use_enable !gtk textui) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo "Minisip defaults to OSS audio."
	einfo "In order to use alsa, select File->Preferences and change"
	einfo "the sound device to \"alsa:hw:0,0\" or other corresponding device."
	einfo "You can also do this in your \$HOME/.minisip.conf after running it for"
	einfo "the first time too, under <sound_device> if you're not using the gtk ui."
}
