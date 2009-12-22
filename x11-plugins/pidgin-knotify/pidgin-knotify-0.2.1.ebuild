# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-knotify/pidgin-knotify-0.2.1.ebuild,v 1.1 2009/12/22 20:21:06 spatz Exp $

EAPI="2"

DESCRIPTION="Plugin that enables knotify for Pidgin in KDE 4 environment"
HOMEPAGE="http://code.google.com/p/pidgin-knotify/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/pidgin
	kde-base/knotify"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
