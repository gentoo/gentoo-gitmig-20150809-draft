# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-rssyl/sylpheed-claws-rssyl-0.4.ebuild,v 1.4 2006/04/17 18:33:24 corsair Exp $

MY_P="${P##sylpheed-claws-}"
SC_BASE="2.0.0_rc1"

DESCRIPTION="This plugin allows you to read your favorite newsfeeds in Claws. RSS 1.0, 2.0 and Atom feeds are currently supported."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://ticho.yweb.sk/rssyl/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 x86"
IUSE="nls"
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}
	net-misc/curl
	dev-libs/libxml2
	nls? ( >=sys-devel/gettext-0.12.1 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install
	dodoc ChangeLog README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
