# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lrzsz/lrzsz-0.12.20-r1.ebuild,v 1.18 2004/11/15 06:52:46 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="communication package providing the X, Y, and ZMODEM file transfer protocols"
HOMEPAGE="http://www.ohse.de/uwe/software/lrzsz.html"
SRC_URI="http://www.ohse.de/uwe/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc amd64 hppa alpha ~mips"
IUSE="nls"

DEPEND=""

src_compile() {
	append-flags -Wstrict-prototypes
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make \
		prefix="${D}/usr" \
		mandir="${D}/usr/share/man" \
		install || die

	dosym /usr/bin/lrb /usr/bin/rb
	dosym /usr/bin/lrx /usr/bin/rx
	dosym /usr/bin/lrz /usr/bin/rz
	dosym /usr/bin/lsb /usr/bin/sb
	dosym /usr/bin/lsx /usr/bin/sx
	dosym /usr/bin/lsz /usr/bin/sz

	dodoc AUTHORS COMPATABILITY ChangeLog NEWS README* THANKS TODO
}
