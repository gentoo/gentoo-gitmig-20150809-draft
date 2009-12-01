# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krossruby/krossruby-4.3.4.ebuild,v 1.1 2009/12/01 11:01:05 wired Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="ruby/krossruby"
inherit kde4-meta

DESCRIPTION="Ruby plugin for the kdelibs/kross scripting framework."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/ruby
"
RDEPEND="${DEPEND}"
