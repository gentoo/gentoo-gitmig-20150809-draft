# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mod_ruby/mod_ruby-1.2.4-r1.ebuild,v 1.1 2005/03/23 16:39:06 caleb Exp $

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

APACHE1_MOD_CONF="/mod_ruby"
APACHE2_MOD_CONF="20_mod_ruby"
APACHE1_MOD_DEFINE="RUBY"
APACHE2_MOD_DEFINE="RUBY"
APACHE1_MOD_FILE="$S/mod_ruby.so"
APACHE2_MOD_FILE="$S/mod_ruby.so"
DOCFILES="ChangeLog COPYING README.* doc/*.html doc/*.css"

need_apache

src_compile() {
	if [ "${APACHE_VERSION}" == "2"]; then
		APXS=${APXS2}
		APACHE_BASEDIR=${APACHE2_BASEDIR}
	else
		APXS=${APXS1}
		APACHE_BASEDIR=${APACHE1_BASEDIR}
	fi

	./configure.rb --with-apxs=${APXS}

#	sed -i -e "s:\(^APACHE_LIBEXECDIR = \$(DESTDIR)${APACHE_BASEDIR}\)/modules:\1-extramodules:" Makefile
	emake || die

	if use doc; then
		cd doc
		emake
	fi
}
