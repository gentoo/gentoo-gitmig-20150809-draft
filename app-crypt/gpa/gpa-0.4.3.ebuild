# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.4.3.ebuild,v 1.9 2002/10/05 05:39:05 drobbins Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Standard GUI for GnuPG"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnupg.org/gpa.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2* app-crypt/gnupg nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	#didn't work as of 0.4.3 (drobbins, 30 Sep 2002)
	#emake || die
	make || die
}

src_install () {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
