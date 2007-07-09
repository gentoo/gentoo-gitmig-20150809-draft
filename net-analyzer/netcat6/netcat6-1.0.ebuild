# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netcat6/netcat6-1.0.ebuild,v 1.6 2007/07/09 16:41:02 jer Exp $

DESCRIPTION="netcat clone with better IPv6 support, improved code, etc..."
HOMEPAGE="http://netcat6.sourceforge.net/"
SRC_URI="ftp://ftp.deepspace6.net/pub/ds6/sources/nc6/nc6-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 m68k ~ppc s390 sh ~sparc x86"
IUSE="ipv6 nls"

DEPEND=""

S=${WORKDIR}/nc6-${PV}

src_compile() {
	econf \
		$(use_enable ipv6) \
		$(use_enable nls) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS BUGS README NEWS TODO CREDITS ChangeLog
}
