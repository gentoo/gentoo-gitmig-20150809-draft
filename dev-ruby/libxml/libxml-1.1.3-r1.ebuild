# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-1.1.3-r1.ebuild,v 1.1 2009/12/15 20:00:53 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_NAME="libxml-ruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README CHANGES"

inherit ruby-fakegem

DESCRIPTION="Ruby libxml with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.6"
DEPEND="${RDEPEND}"

each_ruby_compile() {
	pushd ext/libxml
	${RUBY} extconf.rb || die "extconf.rb failed"

	emake || die "make extension failed"
	popd
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_newins ext/libxml/libxml_ruby.so lib/libxml_ruby.so
}
