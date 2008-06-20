# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mocha/mocha-0.5.6.ebuild,v 1.2 2008/06/20 05:33:50 graaff Exp $

inherit gems

DESCRIPTION="A Ruby library for mocking and stubbing using a syntax like that of JMock, and SchMock"
HOMEPAGE="http://mocha.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-ruby/rake"
RDEPEND="${DEPEND}"
