# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.5.ebuild,v 1.1 2005/09/03 07:35:02 dragonheart Exp $

inherit flag-o-matic eutils

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://oppleman.com/lft/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="VOSTROM"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="virtual/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-installpath.patch
}

src_compile() {
	# avoid suid related security issues.
	append-ldflags -Wl,-z,now

	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc CHANGELOG README TODO
}
