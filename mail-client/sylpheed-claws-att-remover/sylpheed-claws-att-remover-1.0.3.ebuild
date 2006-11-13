# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-att-remover/sylpheed-claws-att-remover-1.0.3.ebuild,v 1.2 2006/11/13 17:03:04 ticho Exp $

inherit eutils

MY_P="${P#sylpheed-claws-}"
MY_P="${MY_P/-/_}"

DESCRIPTION="This plugin lets you remove attachments from mails."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.5.2"

S="${WORKDIR}/${MY_P}"

src_install() {
	pwd
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
