# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/renattach/renattach-1.2.2.ebuild,v 1.4 2010/09/05 23:38:38 xmw Exp $

inherit eutils

DESCRIPTION="Filter that renames/deletes dangerous email attachments."
SRC_URI="http://www.pc-tools.net/files/unix/${P}.tar.gz"
HOMEPAGE="http://www.pc-tools.net/unix/renattach/"

DEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	econf || die "configure error"
	emake || die "build error"
}

src_install () {
	emake DESTDIR="${D}" install || die "install error"
	mv "${D}"/etc/renattach.conf.ex "${D}"/etc/renattach.conf

	dodoc AUTHORS ChangeLog README NEWS
}
