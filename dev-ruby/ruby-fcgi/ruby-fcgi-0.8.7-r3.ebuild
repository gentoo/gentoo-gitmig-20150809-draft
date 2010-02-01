# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.7-r3.ebuild,v 1.2 2010/02/01 11:31:55 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_NAME="${PN/ruby-/}"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README README.signals ChangeLog"

inherit ruby-fakegem eutils

DESCRIPTION="FastCGI library for Ruby"
HOMEPAGE="http://rubyforge.org/projects/fcgi/"
SRC_URI="mirror://rubyforge/fcgi/${P}.tar.gz"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"

each_ruby_compile() {
	case ${RUBY} in
		*ruby18)
			pushd ext/fcgi
			${RUBY} extconf.rb || die "extconf failed"
			emake || die "emake ext failed"
			popd
			cp ext/fcgi/fcgi.so lib || die
			;;
	esac
}
