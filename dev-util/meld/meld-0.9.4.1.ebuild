# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-0.9.4.1.ebuild,v 1.2 2004/10/30 23:01:24 lv Exp $

inherit python gnome.org

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc amd64"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-1.99.15
	>=dev-python/pygtk-1.99.15
	>=dev-python/pyorbit-1.99.0"

# need to add optional dependency for pygtksourceview when it is in portage.
# - liquidx (16 Oct 2004)

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	emake || die "make failed"
}

src_install() {
	# do manual injection of *dirs instead of using make install
	# to get around lack of DESTDIR
	cd ${S}
	python tools/install_paths libdir=/usr/lib/meld < meld > meld.install
	newbin meld.install meld

	insinto /usr/lib/meld
	doins *.py
	python tools/install_paths \
		localedir=/usr/share/locale \
		docdir=/usr/share/doc/${PF} \
		sharedir=/usr/share/meld < paths.py > paths.py.install

	newins paths.py.install paths.py

	insinto /usr/share/meld/glade2
	doins glade2/*
	insinto /usr/share/meld/glade2/pixmaps
	doins glade2/pixmaps/*
	insinto /usr/share/pixmaps
	newins glade2/pixmaps/icon.png meld-icon.png

	insinto /usr/share/applications
	doins meld.desktop

	dodoc AUTHORS COPYING INSTALL TODO.txt
	insinto /usr/share/doc/${PF}
	doins manual/*
}

pkg_postinst() {
	python_mod_optimize /usr/lib/meld
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/meld
}
