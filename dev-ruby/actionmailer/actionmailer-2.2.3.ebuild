# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-2.2.3.ebuild,v 1.7 2009/11/29 09:33:21 a3li Exp $

inherit ruby gems
USE_RUBY="ruby18"

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="http://rubyforge.org/projects/actionmailer/"

LICENSE="MIT"
SLOT="2.2"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="~dev-ruby/actionpack-2.2.3
	>=dev-lang/ruby-1.8.5"
