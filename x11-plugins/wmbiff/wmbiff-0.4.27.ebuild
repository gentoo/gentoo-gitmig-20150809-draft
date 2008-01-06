# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.27.ebuild,v 1.7 2008/01/06 21:22:11 drac Exp $

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
	x11-proto/xproto
	x11-proto/xextproto"

src_compile() {
	econf $(use_enable crypt crypto)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog FAQ NEWS README README.licq TODO wmbiff/sample.wmbiffrc
}
