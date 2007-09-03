# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-rssyl/claws-mail-rssyl-0.15.ebuild,v 1.1 2007/09/03 19:50:57 ticho Exp $

MY_P="${P#claws-mail-}"

DESCRIPTION="This plugin allows you to read your favorite newsfeeds in Claws. RSS 1.0, 2.0 and Atom feeds are currently supported."
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"
DEPEND=">=mail-client/claws-mail-3.0.0
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
	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}
