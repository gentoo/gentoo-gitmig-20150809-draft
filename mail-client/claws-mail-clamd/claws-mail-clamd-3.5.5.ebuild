# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-clamd/claws-mail-clamd-3.5.5.ebuild,v 1.2 2012/12/28 16:28:04 ago Exp $

inherit eutils

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for Claws to scan for viruses"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.9.0"
DEPEND="${RDEPEND}
	app-antivirus/clamav
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}
