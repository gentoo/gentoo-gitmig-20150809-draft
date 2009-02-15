# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-scw/python-scw-0.4.7.ebuild,v 1.3 2009/02/15 23:05:49 patrick Exp $

inherit python

DESCRIPTION="Python binding for Scw."
HOMEPAGE="http://scwwidgets.googlepages.com/"
SRC_URI="http://scwwidgets.googlepages.com/${P}.tar.gz "
LICENSE="LGPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-python/pygtk-2.4
	>=x11-libs/scw-0.4.0"

src_install() {
	python_need_rebuild
	make DESTDIR="${D}" install || die
	dodoc README NEWS ChangeLog AUTHORS
}
