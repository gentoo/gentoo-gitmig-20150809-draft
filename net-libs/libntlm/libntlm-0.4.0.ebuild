# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libntlm/libntlm-0.4.0.ebuild,v 1.5 2007/10/14 15:31:54 corsair Exp $

DESCRIPTION="Microsoft's NTLM authentication (libntlm) library"
HOMEPAGE="http://josefsson.org/libntlm/"
SRC_URI="http://josefsson.org/libntlm/releases/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
