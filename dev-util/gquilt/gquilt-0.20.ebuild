# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gquilt/gquilt-0.20.ebuild,v 1.3 2008/02/18 00:39:21 mr_bones_ Exp $

inherit python

DESCRIPTION="A Python/GTK wrapper for quilt"
HOMEPAGE="http://users.bigpond.net.au/Peter-Williams/"
SRC_URI="mirror://sourceforge/gquilt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-util/quilt
	>=dev-python/pygtk-2"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "s/MODULES_BIN=.*/MODULES_BIN=/;
		s/MODULES_OPT=.*/MODULES_OPT=/" Makefile
	sed -i -e '/install -m 0644 $(MODULES_OPT)/s/\t/&#/g' Makefile
	sed -i -e '/install -m 0644 $(MODULES_BIN)/s/\t/&#/g' Makefile
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "make install failed"
	dodoc ChangeLog
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/share/gquilt
}

pkg_prerm() {
	python_version
	python_mod_cleanup /usr/share/gquilt
}
