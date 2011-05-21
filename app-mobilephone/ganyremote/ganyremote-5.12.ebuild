# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/ganyremote/ganyremote-5.12.ebuild,v 1.3 2011/05/21 08:33:05 tomka Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Gnome frontend to Anyremote"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/anyremote/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bluetooth"

DEPEND="app-mobilephone/anyremote[bluetooth=]
	dev-python/pygtk
	bluetooth? ( dev-python/pybluez )"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
