# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-ssh-gateway/net-ssh-gateway-1.0.0.ebuild,v 1.1 2008/09/20 08:44:27 graaff Exp $

inherit gems

DESCRIPTION="A simple library to assist in enabling tunneled Net::SSH connections"
HOMEPAGE="http://net-ssh.rubyforge.org/gateway"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-ruby/net-ssh-2.0.0"
