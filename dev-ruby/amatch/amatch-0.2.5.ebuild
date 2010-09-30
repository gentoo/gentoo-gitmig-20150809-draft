# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amatch/amatch-0.2.5.ebuild,v 1.5 2010/09/30 01:40:55 ranger Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES README"

inherit ruby-fakegem

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://flori.github.com/amatch/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ia64 ~ppc ppc64 x86"
IUSE=""
