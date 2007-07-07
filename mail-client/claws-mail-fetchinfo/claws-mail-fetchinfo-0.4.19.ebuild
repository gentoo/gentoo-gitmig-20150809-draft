# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-fetchinfo/claws-mail-fetchinfo-0.4.19.ebuild,v 1.1 2007/07/07 14:32:14 ticho Exp $

MY_P="${PN#claws-mail-}-plugin-${PV}"

DESCRIPTION="Plugin for sylpheed-claws to add additional headers with download information"
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-2.10.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc ChangeLog README

	# kill useless files
	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}
