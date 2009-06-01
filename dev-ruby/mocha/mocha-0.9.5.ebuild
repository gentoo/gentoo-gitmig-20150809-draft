# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.9.5.ebuild,v 1.1 2009/06/01 06:30:55 graaff Exp $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-ruby/rake"
RDEPEND="${DEPEND}"
