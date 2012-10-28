# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fakefs/fakefs-0.2.1-r1.ebuild,v 1.6 2012/10/28 17:17:39 armin76 Exp $

EAPI=2

# jruby → Marshal/DeMarshal to clone directories fail; tests fail in
# release 0.2.1
USE_RUBY="ruby18 ree18 ruby19"

# requires sdoc
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CONTRIBUTORS README.markdown"

inherit ruby-fakegem eutils

DESCRIPTION="A fake filesystem. Use it in your tests."
HOMEPAGE="http://github.com/defunkt/fakefs"

LICENSE="as-is" # truly
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-ruby19.patch
}
