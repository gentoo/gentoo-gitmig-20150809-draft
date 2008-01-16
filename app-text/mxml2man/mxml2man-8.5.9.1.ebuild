# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mxml2man/mxml2man-8.5.9.1.ebuild,v 1.2 2008/01/16 10:50:10 drac Exp $

DESCRIPTION="Apple's xml2man in an Autotool fashion"
HOMEPAGE="http://flameeyes.is-a-geek.org/projects#mxml2man"
SRC_URI="http://flameeyes.is-a-geek.org/files/${P}.tar.bz2
	http://digilander.libero.it/dgp85/files/${P}.tar.bz2"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README Syntax
}
