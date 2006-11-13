# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-smime/sylpheed-claws-smime-0.5.6.ebuild,v 1.1 2006/11/13 17:58:58 ticho Exp $

MY_P="${P#sylpheed-claws-}"

DESCRIPTION="This plugin allows you to handle S/MIME signed and/or encrypted mails."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.6.0
		>=app-crypt/gpgme-1.1.1"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
