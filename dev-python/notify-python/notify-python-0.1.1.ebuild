# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/notify-python/notify-python-0.1.1.ebuild,v 1.1 2006/12/28 09:39:55 dev-zero Exp $

NEED_PYTHON=2.3.5

inherit python

DESCRIPTION="Python bindings for libnotify"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.4.0
	>=x11-libs/libnotify-0.4.3"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
