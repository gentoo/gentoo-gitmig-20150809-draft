# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eventlog/eventlog-0.2.4.ebuild,v 1.1 2006/03/02 17:50:15 mr_bones_ Exp $

DESCRIPTION="Support library for syslog-ng"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/syslog_ng/1.9/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS PORTS README
}
