# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rr/rr-0.10.7.ebuild,v 1.1 2010/02/16 11:13:27 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A double framework that features a rich selection of double techniques and a terse syntax"
HOMEPAGE="http://pivotallabs.com/"
SRC_URI="http://github.com/btakita/${PN}/tarball/v${PV} -> ${P}.tar.gz"

S="${WORKDIR}/btakita-${PN}-bbc5109"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend test "dev-ruby/rspec dev-ruby/session"
