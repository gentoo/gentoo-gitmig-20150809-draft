# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-sftp/net-sftp-1.0.0.ebuild,v 1.1 2005/08/10 15:34:43 citizen428 Exp $

inherit ruby

DESCRIPTION="SFTP in pure Ruby"
HOMEPAGE="http://net-ssh.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/4946/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="ruby18"

RDEPEND="dev-ruby/net-ssh"

