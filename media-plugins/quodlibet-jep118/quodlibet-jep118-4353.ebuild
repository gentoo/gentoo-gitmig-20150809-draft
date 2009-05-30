# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/quodlibet-jep118/quodlibet-jep118-4353.ebuild,v 1.2 2009/05/30 15:46:31 ssuominen Exp $

inherit multilib python

DESCRIPTION="Quod Libet plugin which outputs a Jabber User Tunes file."
HOMEPAGE="http://svn.sacredchao.net/svn/quodlibet/trunk/plugins/events/jep118.py"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~ssuominen/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-sound/quodlibet-2"
DEPEND=""

pkg_setup() {
	python_version
	dest=/usr/$(get_libdir)/python${PYVER}/site-packages/quodlibet/plugins/events
}

src_install() {
	insinto ${dest}
	doins jep118.py || die "doins failed"
}

pkg_postinst() {
	python_mod_compile ${dest}/jep118.py
}

pkg_postrm() {
	python_mod_cleanup ${dest}
}
