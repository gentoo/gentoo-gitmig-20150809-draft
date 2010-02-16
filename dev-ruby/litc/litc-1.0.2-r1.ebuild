# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/litc/litc-1.0.2-r1.ebuild,v 1.1 2010/02/16 20:38:37 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_DOC="rerdoc"
RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A tiny ruby module for Amazon EC2 intance metadata"
HOMEPAGE="http://github.com/bkaney/litc"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend test "dev-ruby/shoulda dev-ruby/fakeweb dev-ruby/ruby-debug"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-fixes.patch
}
