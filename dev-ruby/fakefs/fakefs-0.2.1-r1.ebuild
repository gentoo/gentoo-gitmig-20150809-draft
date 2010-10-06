# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fakefs/fakefs-0.2.1-r1.ebuild,v 1.1 2010/10/06 17:45:12 graaff Exp $

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
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

all_ruby_prepare() {
	epatch "${FILESDIR}"/${P}-ruby19.patch
}
