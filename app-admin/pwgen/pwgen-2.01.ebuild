# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pwgen/pwgen-2.01.ebuild,v 1.21 2004/06/25 20:38:14 vapier Exp $

DESCRIPTION="Password Generator"
HOMEPAGE="http://sourceforge.net/projects/pwgen/"
SRC_URI="mirror://sourceforge/pwgen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa"
IUSE="livecd"

DEPEND="virtual/libc"

src_compile() {
	sed -i -e 's:$(prefix)/man/man1:$(mandir)/man1:g' Makefile.in
	econf --sysconfdir=/etc/pwgen || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	use livecd && exeinto /etc/init.d && newexe ${FILESDIR}/pwgen.rc pwgen
}
