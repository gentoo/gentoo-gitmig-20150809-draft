# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.6.ebuild,v 1.1 2005/06/16 23:55:59 smithj Exp $

inherit eutils

DESCRIPTION="A utility that displays its input in a text box on your root window"
HOMEPAGE="http://de-fac.to/book/view/17"
SRC_URI="mirror://sourceforge/xrootconsole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.noversion.patch
	epatch ${FILESDIR}/${P}.makefile.patch
	epatch ${FILESDIR}/${P}.manpage.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make MANDIR=${D}usr/man/man1 BINDIR=${D}usr/bin/ install || die "install failed"
}
