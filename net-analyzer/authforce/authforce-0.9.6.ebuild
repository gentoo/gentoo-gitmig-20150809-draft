# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/authforce/authforce-0.9.6.ebuild,v 1.5 2004/07/15 08:10:12 robbat2 Exp $

DESCRIPTION="An HTTP authentication brute forcer"
HOMEPAGE="http://kapheine.hypa.net/authforce/"
SRC_URI="http://kapheine.hypa.net/authforce/authforce-0.9.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="curl nls"
DEPEND="sys-libs/readline
	curl? ( net-misc/curl )"

src_compile() {
	myconf="`use_with curl`"
	myconf="${myconf} `use_enable nls` "
	econf ${myconf} --with-path=/usr/share/${P}:. || die
	emake || die
}

src_install() {
	dodoc ABOUT-NLS AUTHORS BUGS COPYING INSTALL NEWS README THANKS TODO
	dobin src/authforce
	doman doc/authforce.1.gz
	doinfo doc/authforce.info
	insinto /usr/share/${P}
	doins data/*.lst
}
