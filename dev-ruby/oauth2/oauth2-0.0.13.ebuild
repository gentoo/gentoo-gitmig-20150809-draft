# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/oauth2/oauth2-0.0.13.ebuild,v 1.1 2010/08/22 13:16:46 flameeyes Exp $

EAPI="2"

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="rerdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc CHANGELOG.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth gem."
HOMEPAGE="http://github.com/intridea/oauth2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/faraday >=dev-ruby/multi_json-0.0.4"
ruby_add_bdepend test ">=dev-ruby/rspec-1.2.9"
