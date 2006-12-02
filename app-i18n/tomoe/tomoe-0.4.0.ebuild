# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/tomoe/tomoe-0.4.0.ebuild,v 1.1 2006/12/02 08:25:02 matsuu Exp $

DESCRIPTION="Japanese handwriting recognition engine"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/tomoe/22893/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/ruby
	>=dev-libs/glib-2"
DEPEND="${DEPEND}
	dev-util/pkgconfig"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS TODO
}
