# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-etpan-privacy/sylpheed-claws-etpan-privacy-0.13.ebuild,v 1.2 2006/04/17 18:40:25 corsair Exp $

MY_P="${P##sylpheed-claws-}"
MY_P="${MY_P%%[-_]plugin}"
SC_BASE="2.0.0"

DESCRIPTION="Plugin for sylpheed-claws to sign and verify mails with s/mime or pgp"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/sylpheed-claws-extra-plugins-${SC_BASE}.tar.bz2"
#SRC_URI="http://claws.sylpheed.org/downloads/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
		net-libs/libetpan
		dev-libs/openssl"

S="${WORKDIR}/sylpheed-claws-extra-plugins-${SC_BASE}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
