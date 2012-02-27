# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/syslogger/syslogger-1.2.6.ebuild,v 1.1 2012/02/27 20:45:24 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

# if ever needed
#GITHUB_USER="crohr"
#GITHUB_PROJECT="${PN}"
#RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

inherit ruby-fakegem

DESCRIPTION="Drop-in replacement for the standard Logger, that logs to the syslog"
HOMEPAGE="https://github.com/crohr/syslogger"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	test? ( dev-ruby/rspec:2 )
	doc? ( >=dev-ruby/rdoc-2.4.2 )"
