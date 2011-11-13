# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/termcolor/termcolor-1.2.0.ebuild,v 1.1 2011/11/13 08:21:27 naota Exp $

EAPI="2"
#*** Using highline effectively in JRuby requires manually installing the ffi-ncurses gem.
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="a library for ANSI color formatting like HTML for output in terminal"
HOMEPAGE="http://termcolor.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend dev-ruby/rspec
ruby_add_rdepend ">=dev-ruby/highline-1.5.0"
