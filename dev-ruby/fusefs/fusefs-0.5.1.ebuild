# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fusefs/fusefs-0.5.1.ebuild,v 1.1 2005/11/01 14:19:18 caleb Exp $

inherit ruby

IUSE=""
DESCRIPTION="Define file systems right in Ruby"
HOMEPAGE="http://rubyforge.org/projects/fusefs/"
SRC_URI="http://rubyforge.org/frs/download.php/6794/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="~x86"
DEPEND=">=dev-lang/ruby-1.8 >=sys-fs/fuse-2.3"
