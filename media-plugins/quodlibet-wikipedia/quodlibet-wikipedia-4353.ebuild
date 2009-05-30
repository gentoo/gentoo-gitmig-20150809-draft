# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-wikipedia/quodlibet-wikipedia-4353.ebuild,v 1.1 2009/05/30 15:20:32 ssuominen Exp $

inherit multilib python

DESCRIPTION="Plugin for Quod Libet that searches Wikipedia for an artist or an"
HOMEPAGE="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/songsmenu/wikipedia.py"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-2"
DEPEND=""

pkg_setup() {
	python_version
	dest=/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/songsmenu
}

src_install() {
	insinto ${dest}
	doins wikipedia.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile ${dest}/wikipedia.py
}

pkg_postrm() {
	python_mod_cleanup ${dest}
}
