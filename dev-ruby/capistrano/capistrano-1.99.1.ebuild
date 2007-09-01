# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/capistrano/capistrano-1.99.1.ebuild,v 1.2 2007/09/01 19:55:26 nichoj Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A distributed application deployment system"
HOMEPAGE="http://capify.org/"
SRC_URI="http://gems.rubyonrails.com/gems/${P}.gem"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""
#RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rake-0.7.0
	>=dev-ruby/net-ssh-1.0.10
	>=dev-ruby/net-sftp-1.1.0
	>=dev-ruby/highline-1.2.7"

pkg_postinst() {
	elog "If you are upgrading from <capistrano-1.99, you should convert your"
	elog "project. See http://capify.org/upgrade"
	elog
	elog "Capistrano has replaced switchtower due to naming issues.  If you"
	elog "were previously using switchtower in your Rails apps, you need to"
	elog "manually remove lib/tasks/switchtower.rake from them and then run"
	elog "'cap -A .' in your project directory, making sure to keep deploy.rb"
}
