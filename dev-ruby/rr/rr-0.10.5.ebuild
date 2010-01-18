# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rr/rr-0.10.5.ebuild,v 1.2 2010/01/18 19:20:10 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A double framework that features a rich selection of double techniques and a terse syntax"
HOMEPAGE="http://pivotallabs.com/"
SRC_URI="http://github.com/btakita/${PN}/tarball/v${PV} -> ${P}.tar.gz"

S="${WORKDIR}/btakita-${PN}-32c343a"

# Licensing information provided by upstream (missing in the tarball
# used here):
# http://github.com/btakita/rr/issues#issue/26
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend test "dev-ruby/rspec dev-ruby/session"
