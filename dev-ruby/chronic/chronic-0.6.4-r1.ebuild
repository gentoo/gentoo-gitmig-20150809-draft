# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/chronic/chronic-0.6.4-r1.ebuild,v 1.1 2011/10/21 07:14:28 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby rbx"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"

RUBY_FAKEGEM_GEMSPEC="chronic.gemspec"

inherit ruby-fakegem

DESCRIPTION="Chronic is a natural language date/time parser written in pure Ruby."
HOMEPAGE="https://github.com/mojombo/chronic"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
