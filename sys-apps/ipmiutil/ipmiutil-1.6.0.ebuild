# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ipmiutil/ipmiutil-1.6.0.ebuild,v 1.1 2005/03/25 10:12:47 robbat2 Exp $

inherit flag-o-matic eutils

DESCRIPTION="IPMI Management Utilities"
HOMEPAGE="http://ipmiutil.sf.net/"
SRC_URI="mirror://sourceforge/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/libc
		 >=sys-libs/freeipmi-0.1.0"
DEPEND="${RDEPEND}
		virtual/os-headers"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-link-external-freeipmi.diff
	# The following upstream directories are unneeded/obsolete:
	# freeipmi hpiutil kern test
	# we remove them for safety:
	cd ${S}
	rm -rf freeipmi hpiutil kern test
}

#src_compile() {
#	econf || die "econf failed"
#	emake || die "emake failed"
#}

src_install() {
	# must come first, due to install system that uses 'mv' instead of 'cp'.
	dodoc AUTHORS INSTALL NEWS COPYING README TODO doc/UserGuide

	emake DESTDIR="${D}" install || die "emake install failed"

	# clean up the install a bit
	rm ${D}/usr/share/ipmiutil/{COPYING,README,UserGuide}
}
