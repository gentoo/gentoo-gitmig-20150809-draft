# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bonobo-python/bonobo-python-0.2.0-r5.ebuild,v 1.5 2004/10/23 13:32:21 weeve Exp $

inherit virtualx

IUSE=""

DESCRIPTION="Bonobo bindings for Python"
SRC_URI="http://bonobo-python.lajnux.nu/download/${P}.tar.gz"
HOMEPAGE="http://bonobo-python.lajnux.nu/"

DEPEND="=x11-libs/gtk+-1.2*
	>=gnome-base/bonobo-1.0.9
	<dev-python/gnome-python-1.99
	=dev-python/orbit-python-0.3*
	=dev-python/pygtk-0.6*
	virtual/python"

SLOT="0"
KEYWORDS="x86 sparc ~alpha ~ppc"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}

	# fix configure time sandbox problem
	cd ${S}
	sed -i -e "s:import gnome.config ; gnome.config.sync::" configure

	# fix pygtk detection in configure script
	sed -i -e 's:import gtk:import pygtk; pygtk.require("1.2"); import gtk:' configure

	chmod +x configure
}

src_compile() {
	PYTHON="/usr/bin/python" Xeconf \
		--with-libIDL-prefix=/usr --with-orbit-prefix=/usr \
		--with-oaf-prefix=/usr || die
	Xmake || die
}

src_install() {
	# check if nautilus 1 was found
	grep "#pysite_PYTHON" ${S}/nautilus/Makefile >& /dev/null && \
	( \
		sed -i -e "s/'install-data-am: install-pysitePYTHON'/'install-data-am:'/" ${S}/nautilus/Makefile; \
	)

	einstall || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
