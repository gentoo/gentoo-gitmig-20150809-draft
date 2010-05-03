# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-trayicon/quodlibet-trayicon-4351.ebuild,v 1.4 2010/05/03 22:41:20 ssuominen Exp $

inherit multilib python

DESCRIPTION="Trayicon for Quod Libet"
HOMEPAGE="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/events/trayicon.py"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

pkg_setup() {
	python_version
	dest=/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/events
}

src_install() {
	insinto ${dest}
	doins trayicon.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile ${dest}/trayicon.py
}

pkg_postrm() {
	python_mod_cleanup ${dest}
}
