# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/aria2/aria2-0.8.0.ebuild,v 1.1 2006/09/30 20:13:03 dev-zero Exp $

inherit eutils

KEYWORDS="~x86"

MY_P=${P/_p/+}

DESCRIPTION="A download utility with resuming and segmented downloading with HTTP/HTTPS/FTP/BitTorrent support."
HOMEPAGE="http://aria2.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="ares bittorrent gnutls metalink nls ssl"

CDEPEND="ssl? (
			gnutls? ( net-libs/gnutls )
			!gnutls? ( dev-libs/openssl ) )
		ares? ( >=net-dns/c-ares-1.3.1 )
		bittorrent? ( gnutls? ( dev-libs/libgcrypt ) )
		metalink? ( >=dev-libs/libxml2-2.6.26 )"
DEPEND="${CDEPEND}
		nls? ( sys-devel/gettext )"
RDEPEND="${CDEPEND}
		nls? ( virtual/libiconv virtual/libintl )"

S=${WORKDIR}/${MY_P}

src_compile() {
	use ssl && \
		myconf="${myconf} $(use_with gnutls) $(use_with !gnutls openssl)"

	# Note:
	# - we don't have ares, only libcares
	# - depends on libgcrypt only when using openssl
	econf \
		$(use_enable nls) \
		$(use_enable metalink) \
		$(use_enable bittorrent) \
		--without-ares \
		$(use_with ares libcares) \
		$(use_with metalink libxml2) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/aria2c
	dodoc ChangeLog README AUTHORS TODO NEWS
}
