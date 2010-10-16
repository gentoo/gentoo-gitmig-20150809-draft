# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/kramdown/kramdown-0.11.0.ebuild,v 1.1 2010/10/16 09:19:38 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RAKE_FAKEGEM_DOCDIR="htmldoc/rdoc"
RUBY_FAKEGEM_EXTRADOC="README ChangeLog"

inherit ruby-fakegem

DESCRIPTION="yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition."
HOMEPAGE="http://kramdown.rubyforge.org/"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

all_ruby_install() {
	all_fakegem_install

	doman man/man1/kramdown.1
}
