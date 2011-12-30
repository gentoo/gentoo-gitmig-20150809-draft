# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbeagle/libbeagle-0.3.9-r1.ebuild,v 1.2 2011/12/30 19:25:53 floppym Exp $

EAPI=3
PYTHON_DEPEND="python? 2"
inherit gnome.org python

DESCRIPTION="C and Python bindings for Beagle"
HOMEPAGE="http://beagle-project.org/"

LICENSE="MIT Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc +python"

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.6.19
	python? ( >=dev-python/pygtk-2.6 )
	!<=app-misc/beagle-0.2.18"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_configure() {
	econf	--disable-dependency-tracking \
		$(use_enable python) \
		$(use_enable doc gtk-doc) \
		$(use_enable debug xml-dump)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
}
