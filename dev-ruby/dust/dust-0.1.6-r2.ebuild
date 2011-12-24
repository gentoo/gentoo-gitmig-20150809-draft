# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dust/dust-0.1.6-r2.ebuild,v 1.1 2011/12/24 01:38:14 flameeyes Exp $

EAPI="4"
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Descriptive block syntax definition for Test::Unit."
HOMEPAGE="http://dust.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

# Remove a long-obsolete rubygems method.
all_ruby_prepare() {
	sed -i '/manage_gems/d' rakefile.rb || die "Unable to update rakefile.rb"
}

each_ruby_prepare() {
	sed -i '/manage_gems/d' rakefile.rb || die "Unable to update rakefile.rb"
}
