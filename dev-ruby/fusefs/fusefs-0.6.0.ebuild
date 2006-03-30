# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fusefs/fusefs-0.6.0.ebuild,v 1.3 2006/03/30 03:28:23 agriffis Exp $

inherit ruby

IUSE=""
DESCRIPTION="Define file systems right in Ruby"
HOMEPAGE="http://rubyforge.org/projects/fusefs/"
SRC_URI="http://rubyforge.org/frs/download.php/7830/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="~ia64 x86"
DEPEND=">=dev-lang/ruby-1.8 >=sys-fs/fuse-2.3"
