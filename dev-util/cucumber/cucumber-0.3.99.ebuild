# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber/cucumber-0.3.99.ebuild,v 1.1 2009/09/04 05:56:56 graaff Exp $

inherit ruby gems

DESCRIPTION="Executable feature scenarios"
HOMEPAGE="http://github.com/aslakhellesoy/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

USE_RUBY="ruby18"

RDEPEND=">=dev-ruby/term-ansicolor-1.0.3
	>=dev-ruby/treetop-1.3.0
	>=dev-ruby/polyglot-0.2.8
	>=dev-ruby/diff-lcs-1.1.2
	>=dev-ruby/builder-2.1.2"
DEPEND="${RDEPEND}"
