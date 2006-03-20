# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbiff/wmbiff-0.4.27.ebuild,v 1.4 2006/03/20 19:43:55 gustavoz Exp $

DESCRIPTION="WMBiff is a dock applet for WindowMaker which can monitor up to 5 mailboxes."
SRC_URI="mirror://sourceforge/wmbiff/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/wmbiff/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
	crypt? ( >=net-libs/gnutls-1.2.3
		>=dev-libs/libgcrypt-1.2.1 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="crypt"

src_compile()
{
	local myconf
	if ! use crypt; then
			myconf="--disable-crypto"
	fi
	econf ${myconf} || die
	emake || die
}

src_install()
{
	make DESTDIR="${D}" install || die
	dodoc ChangeLog  FAQ NEWS  README  README.licq  TODO  wmbiff/sample.wmbiffrc
}
