# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/posix-spawn/posix-spawn-0.3.6.ebuild,v 1.1 2011/04/24 20:57:13 flameeyes Exp $

EAPI=2

# jruby → should be supported but does not work with "rake compile"
USE_RUBY="ruby18 ruby19 ree18"
KEYWORDS="~amd64"

RUBY_FAKEGEM_EXTRADOC="README.md TODO HACKING"

inherit ruby-fakegem

DESCRIPTION="Ruby library to access ELF files information"
HOMEPAGE="http://www.flameeyes.eu/projects/ruby-elf"

LICENSE="MIT LGPL-2.1"
SLOT="0"
IUSE="test"

ruby_add_bdepend ">=dev-ruby/rake-compiler-0.7.6"

# https://github.com/rtomayko/posix-spawn/issues/11
RESTRICT=test

each_ruby_compile() {
	${RUBY} -S rake compile || die
}
