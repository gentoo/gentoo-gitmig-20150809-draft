# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-password/ruby-password-0.5.3.ebuild,v 1.1 2009/06/18 18:21:48 graaff Exp $

inherit ruby

DESCRIPTION="Ruby/Password comprises a set of useful methods for creating, verifying and manipulating passwords."
HOMEPAGE="http://www.caliban.org/ruby/"
SRC_URI="http://www.caliban.org/files/ruby/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
USE_RUBY="ruby18"
KEYWORDS="~amd64 ~x86"
DEPEND=">=dev-ruby/ruby-termios-0.9.4"
