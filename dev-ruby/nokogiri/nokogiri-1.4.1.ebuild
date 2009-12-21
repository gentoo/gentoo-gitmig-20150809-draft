# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.4.1.ebuild,v 1.1 2009/12/21 18:50:59 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}"

ruby_add_bdepend dev-ruby/rake-compiler
