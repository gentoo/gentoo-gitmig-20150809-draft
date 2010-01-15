# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.4.1-r1.ebuild,v 1.3 2010/01/15 15:42:58 ranger Exp $

EAPI=2

# jruby → native extension, no Java version available
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~ppc ~ppc64"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}"

ruby_add_bdepend "dev-ruby/rake-compiler dev-ruby/rexical"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-ruby19.patch
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "extension build failed"
}
