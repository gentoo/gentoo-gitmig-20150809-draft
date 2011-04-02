# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.11.ebuild,v 1.1 2011/04/02 13:53:40 patrick Exp $

EAPI="2"

inherit confutils eutils

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"
LICENSE="GPL-3"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc64 ~x86"

DEPEND="sys-libs/talloc"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--sysconfdir=/etc/samba \
		--localstatedir=/var \
	|| die "econf failed"
}

src_compile() {
	emake all || die "emake all failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
}
