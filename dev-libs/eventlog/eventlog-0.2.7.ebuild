# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eventlog/eventlog-0.2.7.ebuild,v 1.3 2008/04/29 09:33:05 armin76 Exp $

inherit libtool eutils

DESCRIPTION="Support library for syslog-ng"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/files/syslog-ng/sources/2.0/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	epunt_cxx
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS CREDITS ChangeLog NEWS PORTS README
}
