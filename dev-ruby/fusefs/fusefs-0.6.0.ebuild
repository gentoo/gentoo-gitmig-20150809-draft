# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fusefs/fusefs-0.6.0.ebuild,v 1.4 2007/03/09 21:29:20 tgall Exp $

inherit ruby

IUSE=""
DESCRIPTION="Define file systems right in Ruby"
HOMEPAGE="http://rubyforge.org/projects/fusefs/"
SRC_URI="http://rubyforge.org/frs/download.php/7830/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="~ia64 ~ppc64 x86"
DEPEND=">=dev-lang/ruby-1.8 >=sys-fs/fuse-2.3"
