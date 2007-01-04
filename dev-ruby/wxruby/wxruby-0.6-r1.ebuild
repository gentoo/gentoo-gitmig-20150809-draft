# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/wxruby/wxruby-0.6-r1.ebuild,v 1.4 2007/01/04 20:27:13 compnerd Exp $

inherit ruby wxwidgets

MY_P="${P}-src"

DESCRIPTION="Ruby language bindings for the wxWidgets GUI toolkit"
HOMEPAGE="http://rubyforge.org/projects/wxruby/"
SRC_URI="http://rubyforge.org/frs/download.php/1983/${MY_P}.tgz"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="gtk"

DEPEND=">=dev-lang/ruby-1.8
	>=x11-libs/wxGTK-2.4.2-r2 <x11-libs/wxGTK-2.5"

WX_GTK_VER="2.4"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cd ${S}/src
	ruby extconf.rb || die

	# wxruby is incompatible with unicode
	use gtk && need-wxwidgets gtk2 || need-wxwidgets gtk
	sed -i -e "s:wx-config:${wxconfig_name}:g" Makefile

	emake || die
}

src_install() {
	erubydoc

	cd ${S}/src
	make DESTDIR=${D} install || die
}
