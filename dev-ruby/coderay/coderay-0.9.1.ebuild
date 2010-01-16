# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/coderay/coderay-0.9.1.ebuild,v 1.5 2010/01/16 14:27:49 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A Ruby library for syntax highlighting."
HOMEPAGE="http://coderay.rubychan.de/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

all_ruby_install() {
	for bin in coderay coderay_stylesheet; do
		ruby_fakegem_binwrapper $bin
	done

	dodoc lib/README || die
}
