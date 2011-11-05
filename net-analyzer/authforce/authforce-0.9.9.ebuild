# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/authforce/authforce-0.9.9.ebuild,v 1.4 2011/11/05 16:07:19 jer Exp $

DESCRIPTION="An HTTP authentication brute forcer"
HOMEPAGE="http://www.divineinvasion.net/authforce"
SRC_URI="http://www.divineinvasion.net/authforce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="curl nls"
DEPEND="sys-libs/readline
	nls? ( sys-devel/gettext )
	curl? ( net-misc/curl )"

src_compile() {
	econf $(use_with curl) $(use_enable nls) --with-path=/usr/share/${PN}/data:. || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS INSTALL NEWS README THANKS TODO
}
