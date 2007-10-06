# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-1.3.3.ebuild,v 1.3 2007/10/06 14:10:31 dertobi123 Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="http://rubyforge.org/projects/actionmailer/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="1.2"
KEYWORDS="~amd64 ~ia64 ppc sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="=dev-ruby/actionpack-1.13.3
	>=dev-lang/ruby-1.8.5"
