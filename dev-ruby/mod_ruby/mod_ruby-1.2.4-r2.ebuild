# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod_ruby/mod_ruby-1.2.4-r2.ebuild,v 1.10 2006/10/20 19:18:37 agriffis Exp $

inherit apache-module

DESCRIPTION="Embeds the Ruby interpreter into Apache"
HOMEPAGE="http://modruby.net/"
SRC_URI="http://modruby.net/archive/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 ~sparc x86"
IUSE="doc"

DEPEND="virtual/ruby
	doc? ( dev-ruby/rdtool )"
RDEPEND="virtual/ruby"

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
