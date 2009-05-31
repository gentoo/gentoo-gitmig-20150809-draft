# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sexy-python/sexy-python-0.1.9.ebuild,v 1.15 2009/05/31 23:23:04 ranger Exp $

inherit python

DESCRIPTION="Python bindings for libsexy."
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy"
SRC_URI="http://releases.chipx86.com/libsexy/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libsexy-${PV}
	>=dev-python/pygtk-2.6.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	python_need_rebuild
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
