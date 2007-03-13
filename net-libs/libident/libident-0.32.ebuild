# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libident/libident-0.32.ebuild,v 1.7 2007/03/13 12:16:02 armin76 Exp $

DESCRIPTION="A small library to interface to the Ident protocol server"
HOMEPAGE="http://www.simphalempin.com/dev/libident/"
SRC_URI="http://people.via.ecp.fr/~rem/libident/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~mips ~ppc ppc64 s390 ~sparc x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
