# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-att-remover/sylpheed-claws-att-remover-0.4.ebuild,v 1.4 2006/04/17 18:31:35 corsair Exp $

inherit eutils

MY_PN="${PN#sylpheed-claws-}"
MY_PN="${MY_PN/-/_}"
MY_P="${MY_PN}-${PV}"
SC_BASE="2.0.0"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"

DESCRIPTION="This plugin lets you remove attachments from mails."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_P}"

src_install() {
	pwd
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
