# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liboauth/liboauth-0.9.1.ebuild,v 1.1 2011/01/12 23:21:44 flameeyes Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="C library implementing the OAuth secure authentication protocol"
HOMEPAGE="http://liboauth.sourceforge.net/"
SRC_URI="http://liboauth.sourceforge.net/pool/${P}.tar.gz"

LICENSE="|| ( GPL-2 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl doc bindist +nss"

CDEPEND="
	nss? ( dev-libs/nss
		curl? ( || ( net-misc/curl[ssl,nss,-gnutls] net-misc/curl[-ssl] ) )
	)

	bindist? ( dev-libs/nss
		curl? ( || ( net-misc/curl[ssl,nss,-gnutls] net-misc/curl[-ssl] ) )
	)

	!bindist? (
		!nss? ( dev-libs/openssl
			curl? ( || ( net-misc/curl[ssl,-nss,-gnutls] net-misc/curl[-ssl] ) )
		)
	)

	net-misc/curl
"

RDEPEND="${CDEPEND}"

DEPEND="${CDEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
		media-fonts/freefont-ttf
	)
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-ldflags.patch"
	eautoreconf
}

src_configure() {
	local myconf=

	if use nss || use bindist; then
		myconf="${myconf} --enable-nss"
	else
		myconf="${myconf} --disable-nss"
	fi

	econf \
		--disable-dependency-tracking \
		--enable-fast-install \
		--disable-static \
		$(use_enable !curl curl) \
		$(use_enable curl libcurl) \
		${myconf}
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		# make sure fonts are found
		export DOTFONTPATH=/usr/share/fonts/freefont-ttf
		emake dox || die "emake dox failed"
	fi
}

src_test() {
	# explicitly allow parallel test build
	emake check || die "emake check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	find "${D}" -name '*.la' -delete || die

	dodoc AUTHORS ChangeLog LICENSE.OpenSSL NEWS README || die "dodoc failed"

	if use doc; then
		dohtml -r doc/html/* || die "dohtml failed"
	fi
}
