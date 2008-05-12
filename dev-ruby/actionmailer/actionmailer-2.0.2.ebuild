# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionmailer/actionmailer-2.0.2.ebuild,v 1.5 2008/05/12 09:44:19 corsair Exp $

inherit ruby gems

DESCRIPTION="Framework for designing email-service layers"
HOMEPAGE="http://rubyforge.org/projects/actionmailer/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="=dev-ruby/actionpack-2.0.2
	>=dev-lang/ruby-1.8.5"
