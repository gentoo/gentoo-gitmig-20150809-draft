# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/autorun/autorun-3.17.ebuild,v 1.4 2009/12/28 16:01:28 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="auto cdrom mounter for the lazy user"
HOMEPAGE="http://autorun.sourceforge.net/"
SRC_URI="mirror://sourceforge/autorun/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/xmlto
	app-text/docbook-xml-dtd:4.1.2"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_configure() {
	export KDEDIR=/usr
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
