# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.1.ebuild,v 1.3 2004/08/04 22:47:44 squinky86 Exp $

IUSE="nls"

DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="mirror://sourceforge/lopster/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"

	econf \
		--with-pthread \
		--with-zlib \
		${myconf} || die "econf failed"

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}
