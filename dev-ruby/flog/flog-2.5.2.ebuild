# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flog/flog-2.5.2.ebuild,v 1.1 2011/08/12 06:11:09 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Flog reports the most tortured code in an easy to read pain report."
HOMEPAGE="http://ruby.sadi.st/"
LICENSE="MIT"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/hoe )"
ruby_add_bdepend "test? ( dev-ruby/hoe dev-ruby/minitest )"

ruby_add_rdepend "=dev-ruby/ruby_parser-2*
	=dev-ruby/sexp-processor-3*"
