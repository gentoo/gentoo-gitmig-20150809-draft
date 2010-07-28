# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/attic/attic-0.5.2.ebuild,v 1.7 2010/07/28 23:13:24 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem eutils

DESCRIPTION="A place for Ruby objects to hide instance variables"
HOMEPAGE="http://solutious.com/"

SRC_URI="http://github.com/delano/${PN}/tarball/${P} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/delano-${PN}-560e6d1"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

ruby_add_bdepend "test? (  dev-ruby/tryouts:0  )"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-fixes.patch
}

each_ruby_test() {
	${RUBY} -Ilib -S sergeant || die "tests failed"
}
