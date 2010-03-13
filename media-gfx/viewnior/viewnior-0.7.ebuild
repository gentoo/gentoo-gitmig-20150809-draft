# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/viewnior/viewnior-0.7.ebuild,v 1.1 2010/03/13 20:24:36 hwoarang Exp $

EAPI="2"

DESCRIPTION="Fast and simple image viewer"
HOMEPAGE="http://xsisqox.github.com/Viewnior/index.html"
SRC_URI="http://cloud.github.com/downloads/xsisqox/Viewnior/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	x11-misc/shared-mime-info"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog* TODO README NEWS || die "dodoc failed"
}
