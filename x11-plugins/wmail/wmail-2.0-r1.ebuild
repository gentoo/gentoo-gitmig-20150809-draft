# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmail/wmail-2.0-r1.ebuild,v 1.5 2004/10/23 16:38:28 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker dock application showing incoming mail"
SRC_URI="http://www.minet.uni-jena.de/~topical/sveng/wmail/${P}.tar.gz"
HOMEPAGE="http://www.dockapps.org/file.php/id/70"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ~sparc"

DEPEND="virtual/libc
	virtual/x11
	>=x11-libs/libdockapp-0.5.0"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.support-libdockapp-0.5.0.patch
}

src_compile()
{
	econf --enable-delt-xpms || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	dobin src/wmail
	dodoc README wmailrc-sample
}

