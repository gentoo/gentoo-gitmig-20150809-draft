# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.6.1.ebuild,v 1.4 2006/08/20 07:50:41 wormo Exp $

inherit ruby gnome2 eutils

IUSE=""

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/6308/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

USE_RUBY="ruby18"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README TODO"

RDEPEND=">=dev-lang/ruby-1.8.0
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.14.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/ruby-gdkpixbuf2-0.12.0
	>=dev-ruby/ruby-amazon-0.8.3
	>=dev-ruby/ruby-zoom-0.2.0"

DEPEND="${RDEPEND}
	app-text/scrollkeeper"

src_compile() {
	ruby install.rb config || die
	ruby install.rb setup || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die

	make_desktop_entry alexandria "Alexandria" "/usr/share/${PN}/icons/alexandria_small.png" "Utility"
}

pkg_postinst() {
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	gnome2_gconf_install

	# For the next line see bug #76726
	${ROOT}/usr/bin/gconftool-2 --shutdown
}
