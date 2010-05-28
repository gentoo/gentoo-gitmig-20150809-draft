# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-trayicon/quodlibet-trayicon-4351.ebuild,v 1.5 2010/05/28 19:10:22 arfrever Exp $

inherit python

DESCRIPTION="Trayicon for Quod Libet"
HOMEPAGE="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/events/trayicon.py"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

src_install() {
	insinto $(python_get_sitedir)/quodlibet/plugins/events
	doins trayicon.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile $(python_get_sitedir)/quodlibet/plugins/events/trayicon.py
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/quodlibet/plugins/events/trayicon.py
}
