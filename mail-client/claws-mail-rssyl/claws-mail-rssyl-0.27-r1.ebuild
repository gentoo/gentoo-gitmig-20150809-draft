# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-rssyl/claws-mail-rssyl-0.27-r1.ebuild,v 1.1 2010/07/18 06:44:24 fauli Exp $

EAPI="3"

inherit eutils

MY_P="${P#claws-mail-}"

DESCRIPTION="Read your favorite newsfeeds in Claws Mail. RSS 1.0, 2.0 and Atom feeds are currently supported"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE="nls"
RDEPEND=">=mail-client/claws-mail-3.7.6
	net-misc/curl
	dev-libs/libxml2
	nls? ( >=sys-devel/gettext-0.12.1 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-newline_hiccup.patch
}

src_configure() {
	econf $(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README || die

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
