# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.9.ebuild,v 1.2 2006/09/25 20:34:43 genstef Exp $

inherit autotools

DESCRIPTION="Google's jabber voice extension library modified by Tapioca"
HOMEPAGE="http://tapioca-voip.sourceforge.net/"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~x86"
IUSE="speex ilbc ortp"
SLOT="0"

RDEPEND="dev-libs/openssl
	ortp? (
		~net-libs/ortp-0.7.1
		ilbc? ( dev-libs/ilbc-rfc3951 )
		speex? ( media-libs/speex )
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	epatch ${FILESDIR}/libjingle-build.diff

	eautoreconf || die "eautoreconf failed"
	econf $(use_enable ortp linphone) \
		$(use_enable ortp) \
		$(use_with ilbc) \
		$(use_with speex) \
		--disable-examples || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
