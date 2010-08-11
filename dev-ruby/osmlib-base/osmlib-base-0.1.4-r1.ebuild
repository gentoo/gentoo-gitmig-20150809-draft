# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/osmlib-base/osmlib-base-0.1.4-r1.ebuild,v 1.1 2010/08/11 01:07:40 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18" #ree18 jruby

RUBY_FAKEGEM_TASK_TEST="-f rakefile.rb test"

RUBY_FAKEGEM_TASK_DOC="-f rakefile.rb rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.txt"

inherit ruby-fakegem

DESCRIPTION="A ruby library for OpenStreetMap."
HOMEPAGE="http://osmlib.rubyforge.org/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/libxml-0.5.4
	dev-ruby/GeoRuby"

ruby_add_bdepend "test? ( dev-ruby/builder )"

all_ruby_install() {
	all_fakegem_install

	docinto /usr/share/doc/${PF}
	dodoc -r examples || die
}
