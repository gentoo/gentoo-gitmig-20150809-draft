# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrootconsole/xrootconsole-0.4-r1.ebuild,v 1.13 2007/07/22 03:18:33 dberkholz Exp $

inherit eutils

DESCRIPTION="A utility that displays its input in a text box on your root window"
HOMEPAGE="http://de-fac.to/bob/xrootconsole/"
SRC_URI="http://de-fac.to/bob/xrootconsole/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_compile() {
	epatch ${FILESDIR}/${P}.parse-color.patch
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin
	make BINDIR=${D}usr/bin/ install || die "install failed"
}
