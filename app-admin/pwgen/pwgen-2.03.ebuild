# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.03.ebuild,v 1.6 2003/09/20 19:56:29 aliz Exp $

DESCRIPTION="Password Generator"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc hppa amd64 alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i -e 's:$(prefix)/man/man1:$(mandir)/man1:g' \
		Makefile.in.new > Makefile.in
}

src_compile() {
	econf --sysconfdir=/etc/pwgen
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
