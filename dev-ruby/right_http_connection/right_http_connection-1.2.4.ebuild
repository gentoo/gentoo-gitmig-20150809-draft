# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/right_http_connection/right_http_connection-1.2.4.ebuild,v 1.1 2010/01/12 14:07:07 flameeyes Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="RightScale's robust HTTP/S connection module"
HOMEPAGE="http://rightscale.rubyforge.org/"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
