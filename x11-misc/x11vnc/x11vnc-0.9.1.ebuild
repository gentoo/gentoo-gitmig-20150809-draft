# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.9.1.ebuild,v 1.8 2007/08/25 14:01:01 vapier Exp $

inherit eutils

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc sh ~sparc x86 ~x86-fbsd"
IUSE="jpeg zlib threads ssl crypt v4l xinerama avahi"

RDEPEND="zlib? ( sys-libs/zlib )
	jpeg? (	media-libs/jpeg )
	ssl? ( dev-libs/openssl )
	avahi? ( >=net-dns/avahi-0.6.4 )
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXdamage
	x11-libs/libXext"

DEPEND="${RDEPEND}
	x11-libs/libXt
	xinerama? ( x11-proto/xineramaproto )
	x11-proto/trapproto
	x11-proto/recordproto
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-ssl.patch
}

src_compile() {
	econf \
		$(use_with avahi) \
		$(use_with xinerama) \
		$(use_with ssl) \
		$(use_with ssl crypto) \
		$(use_with crypt) \
		$(use_with v4l) \
		$(use_with jpeg) \
		$(use_with zlib) \
		$(use_with threads pthread) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc x11vnc/{ChangeLog,README}
}
