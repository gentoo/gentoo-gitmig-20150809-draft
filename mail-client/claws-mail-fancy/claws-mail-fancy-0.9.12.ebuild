# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-fancy/claws-mail-fancy-0.9.12.ebuild,v 1.3 2011/01/15 14:36:42 maekke Exp $

MY_P="${PN#claws-mail-}-${PV}"

DESCRIPTION="Plugin to display HTML with Webkit"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.8"
DEPEND="${RDEPEND}
	>=net-libs/webkit-gtk-1.0
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
