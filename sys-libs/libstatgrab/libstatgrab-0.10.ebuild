# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstatgrab/libstatgrab-0.10.ebuild,v 1.8 2004/11/08 08:44:55 mr_bones_ Exp $

DESCRIPTION="Provides cross platform access to statistics about the system on which it's run."
HOMEPAGE="http://www.i-scream.org/libstatgrab/"
SRC_URI="http://www.mirrorservice.org/sites/ftp.i-scream.org/pub/i-scream/libstatgrab/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 )"
SLOT=0
KEYWORDS="x86 ppc"
IUSE=""
RDEPEND=">=sys-libs/ncurses-5.4-r1
	virtual/libc"

DEPEND="${RDEPEND}
	sys-apps/gawk
	>=sys-apps/sed-4
	sys-apps/grep
	sys-devel/gcc
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:@bindir@/:$(DESTDIR)@bindir@/:g' src/saidar/Makefile.in \
		src/statgrab/Makefile.in
}

src_compile() {
	econf --disable-setgid-binaries --disable-setuid-binaries \
		--disable-deprecated --with-ncurses || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "einstall failed"
	dodoc ChangeLog PLATFORMS NEWS AUTHORS README
}
