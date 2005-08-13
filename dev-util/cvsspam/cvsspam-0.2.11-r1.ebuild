# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsspam/cvsspam-0.2.11-r1.ebuild,v 1.3 2005/08/13 23:08:35 hansmi Exp $

inherit eutils

DESCRIPTION="Utility to send colored HTML CVS-mails"
SRC_URI="http://www.badgers-in-foil.co.uk/projects/cvsspam/${P}.tar.gz"
HOMEPAGE="http://www.badgers-in-foil.co.uk/projects/cvsspam/"
LICENSE="GPL-2"
DEPEND="virtual/libc"
RDEPEND="dev-lang/ruby"
KEYWORDS="ppc x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_install() {
	dobin collect_diffs.rb || die
	dobin cvsspam.rb || die
	dobin record_lastdir.rb || die
	insinto /etc/cvsspam || die
	doins cvsspam.conf || die

	dohtml cvsspam-doc.html
	dodoc COPYING CREDITS TODO cvsspam-doc.pdf
}
