# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/udns/udns-0.0.9.ebuild,v 1.1 2008/06/10 21:34:09 nelchael Exp $

inherit eutils multilib

DESCRIPTION="async-capable DNS stub resolver library"
HOMEPAGE="http://www.corpit.ru/mjt/udns.html"
SRC_URI="http://www.corpit.ru/mjt/udns/${P/-/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# Yes, this doesn't depend on any other library beside "system" set
DEPEND=""

src_compile() {

	# Uses non-standard configure script, econf doesn't work
	./configure || die "configure failed"
	emake staticlib sharedlib || die "make failed"

}

src_install() {

	dolib.so libudns.so.0 || die "dolib.so failed"
	dolib.a libudns.a || die "dolib.a failed"
	dosym libudns.so.0 "/usr/$(get_libdir)/libudns.so" || die "dosym failed"

	insinto /usr/include
	doins udns.h || die "doins failed"

	doman udns.3 || die "doman failed"
	dodoc TODO NOTES || die "dodoc failed"

}
