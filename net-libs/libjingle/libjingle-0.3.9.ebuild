# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libjingle/libjingle-0.3.9.ebuild,v 1.4 2006/11/27 20:07:42 drizzt Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest

inherit autotools eutils

DESCRIPTION="Google's jabber voice extension library modified by Tapioca"
HOMEPAGE="http://tapioca-voip.sourceforge.net/"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/libjingle-build.diff
	eautoreconf
}

src_compile() {
	econf $(use_enable ortp linphone) \
		$(use_enable ortp) \
		$(use_with ilbc) \
		$(use_with speex) \
		--disable-examples || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
