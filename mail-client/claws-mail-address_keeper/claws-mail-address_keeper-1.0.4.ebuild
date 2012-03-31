# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-address_keeper/claws-mail-address_keeper-1.0.4.ebuild,v 1.4 2012/03/31 14:15:20 klausman Exp $

inherit eutils

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for Claws to collect all recipients in an address book folder"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
