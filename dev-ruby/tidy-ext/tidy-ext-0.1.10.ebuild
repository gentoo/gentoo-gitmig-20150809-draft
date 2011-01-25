# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tidy-ext/tidy-ext-0.1.10.ebuild,v 1.1 2011/01/25 06:50:49 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_DOCDIR="rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem eutils

DESCRIPTION="W3C HTML Tidy library implemented as a Ruby extension."
HOMEPAGE="http://github.com/carld/tidy"

LICENSE="HTML-Tidy"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

each_ruby_prepare() {
	mkdir lib || die

	sed -i -e '/check_dependencies/d' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext/tidy extconf.rb || die "Unable to configure extension."
}

each_ruby_compile() {
	emake -Cext/tidy || die
	cp ext/tidy/tidy$(get_modname) lib/ || die "Unable to copy extension."
}
