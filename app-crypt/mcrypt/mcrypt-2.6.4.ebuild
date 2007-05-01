# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.4.ebuild,v 1.15 2007/05/01 06:51:56 robbat2 Exp $

DESCRIPTION="replacement of the old unix crypt(1)"
HOMEPAGE="http://mcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mcrypt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

DEPEND=">=dev-libs/libmcrypt-2.5.7
	>=app-crypt/mhash-0.8.15"

src_unpack() {
	unpack ${A}
	for f in ${S}/Makefile.am ${S}/Makefile.in; do
		sed -e 's,$(bindir),$(DESTDIR)$(bindir),g' -i ${f} || die 'sed failed'
	done
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf} || die "configure error"
	emake || die "make error"
}

src_install() {
	emake install DESTDIR="${D}" || die "install error"
	dodoc README NEWS AUTHORS THANKS TODO
}
