# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.01.ebuild,v 1.8 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Password Generator"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	# Fix the Makefile
	cp Makefile.in Makefile.in.new
	sed -e 's:$(prefix)/man/man1:$(mandir)/man1:g' \
		Makefile.in.new > Makefile.in

	econf --sysconfdir=/etc/pwgen || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
