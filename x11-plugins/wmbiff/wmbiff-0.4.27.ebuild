# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.27.ebuild,v 1.9 2012/05/05 05:12:01 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="crypt"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm
	crypt? ( >=net-libs/gnutls-1.2.3
		>=dev-libs/libgcrypt-1.2.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto
	x11-proto/xextproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gnutls.patch
	sed -i -e '/AC_PATH_XTRA_CORRECTED/d' configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable crypt crypto)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog FAQ NEWS README README.licq TODO wmbiff/sample.wmbiffrc
}
