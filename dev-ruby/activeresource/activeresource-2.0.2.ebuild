# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activeresource/activeresource-2.0.2.ebuild,v 1.6 2008/05/12 09:41:15 corsair Exp $

inherit ruby gems

DESCRIPTION="Think Active Record for web resources.."
HOMEPAGE="http://rubyforge.org/projects/activeresource/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 ~ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	~dev-ruby/activesupport-2.0.2"
