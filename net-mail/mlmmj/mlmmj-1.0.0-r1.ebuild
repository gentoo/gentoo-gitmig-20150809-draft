# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mlmmj/mlmmj-1.0.0-r1.ebuild,v 1.2 2005/03/18 11:08:56 tigger Exp $

inherit eutils

DESCRIPTION="Mailing list managing made joyful"
HOMEPAGE="http://mlmmj.mmj.dk/"
SRC_URI="http://mlmmj.mmj.dk/files/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/mta"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/mlmmj-1.0.0-r1-print.patch
}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
