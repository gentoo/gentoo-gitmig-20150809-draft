# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/syslogger/syslogger-1.2.5.ebuild,v 1.1 2012/01/22 18:45:01 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

# if ever needed
#GITHUB_USER="codegram"
#GITHUB_PROJECT="${PN}"
#RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

inherit ruby-fakegem

DESCRIPTION="Drop-in replacement for the standard Logger, that logs to the syslog"
HOMEPAGE="https://github.com/crohr/syslogger"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	test? (
		=dev-ruby/rspec-1.3*
	)
	doc? ( dev-ruby/rdoc )"
