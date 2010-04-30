# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/faraday/faraday-0.4.3.ebuild,v 1.1 2010/04/30 18:12:06 flameeyes Exp $

EAPI="2"

USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC="rerdoc"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="HTTP/REST API client library with pluggable components"
HOMEPAGE="http://github.com/technoweenie/faraday"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/rack dev-ruby/addressable"
ruby_add_bdepend test "virtual/ruby-test-unit"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
}
