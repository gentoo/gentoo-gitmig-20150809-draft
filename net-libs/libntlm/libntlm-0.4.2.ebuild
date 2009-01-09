# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libntlm/libntlm-0.4.2.ebuild,v 1.8 2009/01/09 23:06:06 gentoofan23 Exp $

DESCRIPTION="Microsoft's NTLM authentication (libntlm) library"
HOMEPAGE="http://josefsson.org/libntlm/"
SRC_URI="http://josefsson.org/libntlm/releases/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ppc64 ~sparc ~x86"
IUSE=""

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
