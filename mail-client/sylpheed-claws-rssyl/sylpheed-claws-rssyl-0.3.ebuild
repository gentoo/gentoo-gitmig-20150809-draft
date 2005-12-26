# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-rssyl/sylpheed-claws-rssyl-0.3.ebuild,v 1.1 2005/12/26 20:40:55 ticho Exp $

MY_P="${P##sylpheed-claws-}"
SC_BASE="2.0.0_rc1"

DESCRIPTION="This plugin allows you to read your favorite newsfeeds in Claws. RSS 1.0, 2.0 and Atom feeds are currently supported."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://ticho.yweb.sk/rssyl/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
	net-misc/curl
	dev-libs/libxml2"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc ChangeLog README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
