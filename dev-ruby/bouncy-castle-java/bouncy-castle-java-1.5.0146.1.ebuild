# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bouncy-castle-java/bouncy-castle-java-1.5.0146.1.ebuild,v 1.1 2011/04/30 06:08:04 graaff Exp $

EAPI=2

USE_RUBY=jruby

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A gem redistribution of 'Legion of the Bouncy Castle Java cryptography APIs'"
HOMEPAGE="http://www.bouncycastle.org/java.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
