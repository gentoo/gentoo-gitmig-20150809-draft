# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-att-remover/claws-mail-att-remover-1.0.10.ebuild,v 1.3 2009/01/25 16:25:40 maekke Exp $

inherit eutils

MY_P="${P#claws-mail-}"
MY_P="${MY_P/-/_}"

DESCRIPTION="This plugin lets you remove attachments from mails."
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.0"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f "${D}"usr/lib*/claws-mail/plugins/*.{a,la}
}
