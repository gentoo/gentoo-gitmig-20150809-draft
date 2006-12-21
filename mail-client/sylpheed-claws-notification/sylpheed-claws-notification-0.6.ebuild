# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-notification/sylpheed-claws-notification-0.6.ebuild,v 1.2 2006/12/21 17:00:56 corsair Exp $

MY_P="${PN#sylpheed-claws-}_plugin-${PV}"

DESCRIPTION="Plugin providing various ways to notify user of new and unread mail."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.6.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
