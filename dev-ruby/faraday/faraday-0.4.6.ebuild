# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/faraday/faraday-0.4.6.ebuild,v 1.1 2010/05/29 12:51:57 flameeyes Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_TASK_DOC="rerdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="HTTP/REST API client library with pluggable components"
HOMEPAGE="http://github.com/technoweenie/faraday"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rack-1.0.1 >=dev-ruby/addressable-2.1.1"
ruby_add_bdepend test "virtual/ruby-test-unit"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.5-gentoo.patch
}
