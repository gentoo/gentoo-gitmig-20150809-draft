# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-rssyl/sylpheed-claws-rssyl-0.5.ebuild,v 1.4 2006/10/20 21:16:33 kloeri Exp $

MY_P="${P##sylpheed-claws-}"
SC_BASE="2.3.0"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"

DESCRIPTION="This plugin allows you to read your favorite newsfeeds in Claws. RSS 1.0, 2.0 and Atom feeds are currently supported."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc64 x86"
IUSE="nls"
DEPEND=">=mail-client/sylpheed-claws-2.2.3
	net-misc/curl
	dev-libs/libxml2
	nls? ( >=sys-devel/gettext-0.12.1 )"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_P}"

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
