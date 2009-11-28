# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activeresource/activeresource-2.3.5.ebuild,v 1.1 2009/11/28 09:22:37 a3li Exp $

inherit ruby gems
USE_RUBY="ruby18 ruby19"

DESCRIPTION="Think Active Record for web resources.."
HOMEPAGE="http://rubyforge.org/projects/activeresource/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.6
	~dev-ruby/activesupport-${PV}"
RDEPEND="${DEPEND}"
