# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.4.1-r1.ebuild,v 1.9 2010/10/25 01:51:23 jer Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem eutils

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${RDEPEND}"

ruby_add_bdepend "dev-ruby/rake-compiler dev-ruby/rexical dev-ruby/hoe"

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-ruby19.patch
}

each_ruby_compile() {
	case ${RUBY} in
		*jruby)
			einfo "NokoGiri does not build a native extension for JRury."
			einfo "Instead, the FFI library will be used."
			;;
		*)
			${RUBY} -S rake compile || die "extension build failed"
			;;
	esac
}
