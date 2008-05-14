# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/notify-python/notify-python-0.1.1.ebuild,v 1.9 2008/05/14 06:35:17 corsair Exp $

NEED_PYTHON=2.3.5

inherit python

DESCRIPTION="Python bindings for libnotify"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.4.0
	>=x11-libs/libnotify-0.4.3"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0/pynotify
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0/pynotify
}
