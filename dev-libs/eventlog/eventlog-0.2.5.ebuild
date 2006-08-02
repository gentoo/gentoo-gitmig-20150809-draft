# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eventlog/eventlog-0.2.5.ebuild,v 1.1 2006/08/02 03:37:52 mr_bones_ Exp $

DESCRIPTION="Support library for syslog-ng"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/syslog-ng/2.0/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS PORTS README
}
