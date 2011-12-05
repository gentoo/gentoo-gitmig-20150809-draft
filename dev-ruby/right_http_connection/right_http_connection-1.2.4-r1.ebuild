# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/right_http_connection/right_http_connection-1.2.4-r1.ebuild,v 1.7 2011/12/05 14:22:42 naota Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="RightScale's robust HTTP/S connection module"
HOMEPAGE="http://rightscale.rubyforge.org/"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

all_ruby_prepare() {
	# This patch is taken from the http_connection fork
	# http://github.com/appoxy/http_connection
	# It's the only change in the 1.3.0 release, which is otherwise
	# quite a setback in term of gems.
	epatch "${FILESDIR}"/${P}+ruby-1.9.patch
}
