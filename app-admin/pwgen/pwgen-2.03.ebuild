# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.03.ebuild,v 1.5 2003/08/07 09:29:56 taviso Exp $

DESCRIPTION="Password Generator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc hppa amd64 alpha"

DEPEND="virtual/glibc"

src_compile() {
	# Fix the Makefile
	cp Makefile.in Makefile.in.new
	sed -e 's:$(prefix)/man/man1:$(mandir)/man1:g' \
		Makefile.in.new > Makefile.in

	econf --sysconfdir=/etc/pwgen
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
