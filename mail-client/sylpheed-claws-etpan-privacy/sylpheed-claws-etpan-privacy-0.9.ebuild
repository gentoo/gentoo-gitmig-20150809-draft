# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-etpan-privacy/sylpheed-claws-etpan-privacy-0.9.ebuild,v 1.1 2005/08/13 10:47:56 genone Exp $

MY_P="${P##sylpheed-claws-}"
MY_P="${MY_P%%[-_]plugin}"
SC_BASE="1.9.13"

DESCRIPTION="Plugin for sylpheed-claws to sign and verify mails with s/mime or pgp"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="mirror://sourceforge/sylpheed-claws/sylpheed-claws-plugins-${SC_BASE}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
		net-libs/libetpan
		dev-libs/openssl"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
