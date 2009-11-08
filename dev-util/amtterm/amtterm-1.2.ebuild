# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/amtterm/amtterm-1.2.ebuild,v 1.2 2009/11/08 11:15:50 patrick Exp $

EAPI="2"

inherit eutils

SLOT="0"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DESCRIPTION="A nice tool to manage amt-enabled machines"
HOMEPAGE="http://dl.bytesex.org/releases/amtterm/"

SRC_URI="http://dl.bytesex.org/releases/${PN}/${P}.tar.gz"

RDEPEND="dev-perl/SOAP-Lite"

src_compile() {
	prefix="/usr" emake
}

src_install() {
	prefix="/usr" emake DESTDIR=${D} install
}
