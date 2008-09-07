# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python-extras/gnome-python-extras-2.19.1-r2.ebuild,v 1.2 2008/09/07 19:02:57 tester Exp $

inherit eutils gnome2 python virtualx autotools

DESCRIPTION="GNOME 2 Bindings for Python"
HOMEPAGE="http://www.pygtk.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc firefox seamonkey xulrunner"

RDEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.6
	>=dev-python/gnome-python-2.10
	>=dev-python/pygtk-2.4
	=gnome-extra/gtkhtml-2*
	xulrunner? ( =net-libs/xulrunner-1.8* )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )
	>=x11-libs/libgksu-2.0.4
	>=dev-libs/gdl-0.6.1
	>=app-text/gtkspell-2"
	# =gnome-extra/libgda-3*
	# This used to be wrongly libgda-1*, but as configure is automagic,
	# it just didn't build libgda bindings before as libgda-3 is p.masked.
	# Leaving it automagic and dep lacking as there are no notable users of
	# these bindings as testified by the lack of bug reports for this
	# breakage. Should be fixed after libgda-3 gets unmasked or this ebuild
	# is split into many per bug 108479

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

# Tests are broken and not that useful anyway, see bug #209846
RESTRICT="test"

pkg_setup() {
	if ! built_with_use --missing true dev-libs/gdl gnome; then
		eerror "If you want to build ${PN} with >=dev-libs/gdl-0.7.1, you"
		eerror "need to build dev-libs/gdl with the the 'gnome' USE flag."
		die "gdl must be built with USE='gnome'"
	fi

	# only controls linking, can't disable w/o a patch :)
	if use xulrunner; then
		G2CONF="${G2CONF} --with-gtkmozembed=xulrunner"
	elif use firefox; then
		G2CONF="${G2CONF} --with-gtkmozembed=firefox"
	elif use seamonkey; then
		G2CONF="${G2CONF} --with-gtkmozembed=seamonkey"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# change mozilla to seamonkey
	sed -i -e 's:1.2b):1.0.0):;s:mozilla):seamonkey):' configure.ac

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	eautoreconf
}

src_test() {
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_version
	python_mod_cleanup "${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0"
}
