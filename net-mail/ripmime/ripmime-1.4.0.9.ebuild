# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ripmime/ripmime-1.4.0.9.ebuild,v 1.1 2009/05/22 20:05:13 dertobi123 Exp $

inherit multilib

DESCRIPTION="extract attachment files out of a MIME-encoded email pack"
HOMEPAGE="http://pldaniels.com/ripmime/"
SRC_URI="http://www.pldaniels.com/ripmime/${P}.tar.gz"

LICENSE="Sendmail"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" || die
	emake -j1 CFLAGS="${CFLAGS}" libripmime || die
}

src_install() {
	dobin ripmime || die
	doman ripmime.1
	dodoc CHANGELOG INSTALL README TODO
	mkdir -p "${D}"/usr/$(get_libdir)
	mkdir -p "${D}"/usr/include/ripmime
	install mime.h  "${D}"/usr/include/ripmime
	install ripmime-api.h  "${D}"/usr/include/ripmime
	install libripmime.a "${D}"/usr/$(get_libdir)
}
