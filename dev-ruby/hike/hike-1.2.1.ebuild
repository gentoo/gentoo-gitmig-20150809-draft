# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/hike/hike-1.2.1.ebuild,v 1.2 2011/12/28 07:41:46 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Hike is a Ruby library for finding files in a set of paths."
HOMEPAGE="https://github.com/sstephenson/hike"
LICENSE="MIT"
SRC_URI="https://github.com/sstephenson/hike/tarball/v${PV} -> ${P}.tgz"
RUBY_S="sstephenson-hike-*"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

each_ruby_test() {
	${RUBY} -Ilib:test -S testrb test || die
}
