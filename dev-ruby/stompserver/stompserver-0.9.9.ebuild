# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/stompserver/stompserver-0.9.9.ebuild,v 1.1 2009/03/25 17:02:32 caleb Exp $

inherit gems

DESCRIPTION="Stomp messaging server with FIFO queues, queue monitoring, and basic authentication."
HOMEPAGE="http://stompserver.rubyforge.org"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

USE_RUBY="ruby18"

RDEPEND="dev-ruby/daemons
	dev-ruby/eventmachine
	dev-ruby/hoe"
DEPEND="${RDEPEND}"

src_install() {
	gems_src_install
	doinitd "${FILESDIR}"/stompserver
}
