# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-attachwarner/claws-mail-attachwarner-0.2.8.ebuild,v 1.1 2007/09/03 19:17:22 ticho Exp $

MY_P="${P#claws-mail-}"

DESCRIPTION="Warns when the user composes a message mentioning an attachment in
the message body without attaching any files to the message."
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"
DEPEND=">=mail-client/claws-mail-3.0.0
		nls? ( >=sys-devel/gettext-0.12.1 )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README

	# kill useless files
	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}
