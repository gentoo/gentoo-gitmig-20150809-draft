# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-smime/sylpheed-claws-smime-0.5.5.ebuild,v 1.1 2006/10/03 16:09:39 ticho Exp $

MY_P="${P##sylpheed-claws-}"
MY_PN="${PN##sylpheed-claws-}"
SC_BASE="2.5.2"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"
DESCRIPTION="This plugin allows you to handle S/MIME signed and/or encrypted mails."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
		>=app-crypt/gpgme-1.1.1"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
