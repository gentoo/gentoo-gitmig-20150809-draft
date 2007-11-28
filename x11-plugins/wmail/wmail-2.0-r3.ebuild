# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmail/wmail-2.0-r3.ebuild,v 1.4 2007/11/28 21:52:50 armin76 Exp $

inherit eutils

DESCRIPTION="Window Maker dock application showing incoming mail"
HOMEPAGE="http://www.dockapps.org/file.php/id/70"
SRC_URI="http://www.minet.uni-jena.de/~topical/sveng/wmail/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="x11-libs/libdockapp"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.support-libdockapp-0.5.0.patch

	# make from parsing in maildir format faster, thanks
	# to Stanislav Kuchar
	epatch "${FILESDIR}"/${P}.maildir-parse-from.patch
}

src_compile() {
	econf --enable-delt-xpms || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	dobin src/wmail
	dodoc README wmailrc-sample
}
