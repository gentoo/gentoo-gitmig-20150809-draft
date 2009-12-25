# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rcov/rcov-0.9.6-r1.ebuild,v 1.1 2009/12/25 15:24:23 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="THANKS BLURB"

inherit ruby-fakegem

DESCRIPTION="A ruby code coverage analysis tool"
HOMEPAGE="http://eigenclass.org/hiki.rb?rcov"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

# TODO: both emacs and vim support are present in this package, they
# should probably be added to the ebuild as well.
IUSE=""

# tests fail because the gem does not package the needed files, and
# there is no tag in github to fetch a tarball.
# http://github.com/relevance/rcov/issues/#issue/36
RESTRICT=test

each_ruby_compile() {
	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		${RUBY} -S rake ext/rcovrt/rcovrt.so || die "build failed"
	fi
}

each_ruby_install() {
	each_fakegem_install

	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		ruby_fakegem_newins ext/rcovrt/rcovrt.so lib/rcovrt.so
	fi
}
