# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tryouts/tryouts-0.8.7.ebuild,v 1.1 2010/02/17 19:13:39 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="High-level testing library (DSL) for Ruby codes and command-line applications"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-fixes.patch
}

RESTRICT=test

each_ruby_test() {
	${RUBY} -Ilib bin/sergeant || die "Tests failed"
}
