# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/capistrano/capistrano-1.1.0.ebuild,v 1.1 2006/03/09 13:37:26 caleb Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="A distributed application deployment system"
HOMEPAGE="http://rubyforge.org/projects/capistrano/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT="test"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/rake-0.7.0
	>=dev-ruby/net-ssh-1.0.8
	>=dev-ruby/net-sftp-1.1.0"

pkg_postinst()
{
	einfo
	einfo "Capistrano has replaced switchtower due to naming issues.  If you were previously using"
	einfo "switchtower in your Rails apps, you need to manuall remove lib/tasks/switchtower.rake"
	einfo "from them and then run 'cap -A .' in your project director, making sure to keep deploy.rb"
	einfo
}
