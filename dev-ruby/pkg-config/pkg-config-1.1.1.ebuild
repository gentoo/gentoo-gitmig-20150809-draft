# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pkg-config/pkg-config-1.1.1.ebuild,v 1.2 2011/12/04 14:06:04 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="NEWS README.rdoc"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="A pkg-config implementation by Ruby"
HOMEPAGE="https://github.com/rcairo/pkg-config"
LICENSE="|| ( LGPL-2 LGPL-2.1 LGPL-3 )"

KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
SLOT="0"
IUSE=""

RESTRICT="test"

all_ruby_prepare() {
	cp "${FILESDIR}"/${PN}-1.1.1-Manifest.txt Manifest.txt || die
}
