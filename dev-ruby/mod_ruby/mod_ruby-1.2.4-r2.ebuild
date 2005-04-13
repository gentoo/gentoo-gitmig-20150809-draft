# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod_ruby/mod_ruby-1.2.4-r2.ebuild,v 1.2 2005/04/13 12:48:43 caleb Exp $

inherit apache-module

DESCRIPTION="Embeds the Ruby interpreter into Apache"
HOMEPAGE="http://modruby.net/"
SRC_URI="http://modruby.net/archive/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~sparc ~x86 ~ppc ~amd64 ~ppc64"
IUSE="doc"

DEPEND="virtual/ruby
	doc? ( dev-ruby/rdtool )"

APACHE1_MOD_CONF="mod_ruby"
APACHE2_MOD_CONF="21_mod_ruby"
APACHE1_MOD_DEFINE="RUBY"
APACHE2_MOD_DEFINE="RUBY"
APACHE1_MOD_FILE="${PN}.so"
APACHE2_MOD_FILE="${PN}.so"
DOCFILES="ChangeLog COPYING README.* doc/*.html doc/*.css"

need_apache

src_compile() {
	use apache2 || ./configure.rb --with-apxs=${APXS1}
	use apache2 && ./configure.rb --with-apxs=${APXS2}

	./configure.rb --with-apxs=${APXS}

	emake || die "make failed"

	if use doc; then
		cd doc
		emake || die "make failed"
	fi
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"

	if use doc; then
		dohtml doc/*.css doc/*.html
	fi

	apache-module_src_install
}
