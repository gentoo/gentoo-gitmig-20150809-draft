# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-newmail/sylpheed-claws-newmail-0.0.7.ebuild,v 1.2 2006/11/13 17:35:19 ticho Exp $

MY_P="${P#sylpheed-claws-}"

DESCRIPTION="Plugin which writes a header summary to a log file for each received mail."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.5.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
