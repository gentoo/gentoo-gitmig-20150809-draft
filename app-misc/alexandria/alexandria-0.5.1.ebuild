# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/alexandria/alexandria-0.5.1.ebuild,v 1.1 2005/03/29 09:56:28 citizen428 Exp $

inherit ruby gnome2

IUSE=""

DESCRIPTION="A GNOME application to help you manage your book collection"
HOMEPAGE="http://alexandria.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/3698/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

USE_RUBY="ruby18"

DOCS="AUTHORS COPYING ChangeLog HACKING NEWS README TODO"

RDEPEND="virtual/ruby
	>=dev-ruby/ruby-gettext-0.6.1
	>=dev-ruby/ruby-gnome2-0.12.0
	>=dev-ruby/ruby-libglade2-0.12.0
	>=dev-ruby/ruby-gconf2-0.12.0
	>=dev-ruby/ruby-gdkpixbuf2-0.12.0
	>=dev-ruby/ruby-amazon-0.8.3"

src_compile() {
	#echo $GCONF_CONFIG_SOURCE
	ruby install.rb config || die
	ruby install.rb setup || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
}

pkg_postinst() {
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	# More or less copied from gnome2_gconf_install, which didn't work here
	export GCONF_CONFIG_SOURCE=`${ROOT}/usr/bin/gconftool-2 --get-default-source`
	einfo "Installing GNOME 2 GConf schemas"
	${ROOT}/usr/bin/gconftool-2 --makefile-install-rule ${S}/schemas/* 1>/dev/null
	# For the next line see bug #76726
	${ROOT}/usr/bin/gconftool-2 --shutdown
}
