# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.4.3.ebuild,v 1.15 2004/02/22 18:11:24 agriffis Exp $

DESCRIPTION="Standard GUI for GnuPG"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gpa/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpa.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	app-crypt/gnupg
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf}

	#didn't work as of 0.4.3 (drobbins, 30 Sep 2002)
	#emake || die
	make || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
