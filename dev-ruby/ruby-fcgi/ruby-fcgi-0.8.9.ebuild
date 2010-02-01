# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-fcgi/ruby-fcgi-0.8.9.ebuild,v 1.1 2010/02/01 10:51:20 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC="rdoc"

# there are not tests, the only file is a moot fake file
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README README.signals ChangeLog"

inherit ruby-fakegem

DESCRIPTION="FastCGI library for Ruby. Forked version."
HOMEPAGE="http://github.com/saks/fcgi"

KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
LICENSE="Ruby"

DEPEND="dev-libs/fcgi"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"

each_ruby_compile() {
	pushd ext/fcgi
	${RUBY} extconf.rb || die "extconf failed"
	emake || die "emake ext failed"
	popd
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_newins ext/fcgi/fcgi.so lib/fcgi.so
}

pkg_postinst() {
	elog "Starting from ruby-fcgi-0.8.9 the dev-ruby/ruby-fcgi package installs"
	elog "the ruby-fcgi gem rather than the previous fcgi gem."
	elog "This is a forked version that is compatible with Ruby 1.9 and provides"
	elog "proper documentation infrastructure that we can make use of."
	elog ""
	elog "If you have any reason to prefer the original fcgi gem, you should"
	elog "let us know on the bugzilla (http://bugs.gentoo.org/) and we'll see"
	elog "to add the other gem as an alternative."
}
