# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-importexport/quodlibet-importexport-4353.ebuild,v 1.1 2009/05/30 15:10:07 ssuominen Exp $

inherit multilib python

DESCRIPTION="Quod Libet plugin that can import or export metadata information."
HOMEPAGE="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/songsmenu/cddb.py"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-2"
DEPEND=""

pkg_setup() {
	python_version
	dest=/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/songsmenu
}

src_install() {
	insinto ${dest}
	doins importexport.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile ${dest}/importexport.py
}

pkg_postrm() {
	python_mod_cleanup ${dest}
}
