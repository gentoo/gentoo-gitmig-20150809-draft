# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tmsnc/tmsnc-0.3.2.ebuild,v 1.2 2007/01/16 06:12:29 josejx Exp $

DESCRIPTION="TMSNC is a textbased MSN client written in C."
HOMEPAGE="http://tmsnc.sourceforge.net/"
SRC_URI="mirror://sourceforge/tmsnc/${P}.tar.gz"

LICENSE="IRPDL"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="ssl talkfilters"

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.4
	ssl? ( >=dev-libs/openssl-0.9.7d )
	talkfilters? ( >=app-text/talkfilters-2.3.4 )"

src_compile() {
	local myconf
	use ssl \
		|| myconf="${myconf} --without-ssl"
	use talkfilters \
		|| myconf="${myconf} --without-talkfilters"
	econf ${myconf} || die "Configure failed"
	emake || die "Make failed"
}
src_install() {
	make DESTDIR=${D} install || die "Make install failed"
	dodoc AUTHORS ChangeLog README NEWS
}
pkg_postinst() {
	einfo "If you want talkfilters support you need to add"
	einfo "USE=talkfilters to enable support in this package"
}
