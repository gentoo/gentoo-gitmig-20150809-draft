# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.7.ebuild,v 1.2 2004/04/08 20:01:48 squinky86 Exp $

DESCRIPTION="library for bible reading software"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="ftp://ftp.crosswire.org/pub/sword/source/v1.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="icu curl"
DEPEND="virtual/glibc
	sys-libs/zlib
	curl? ( >=net-misc/curl-7.9 )
	icu? ( dev-libs/icu )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	econf --without-clucene --without-lucene `use_with icu` `use_with curl` || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall || die "install failed"

	dodoc AUTHORS CODINGSTYLE INSTALL ChangeLog README
	cp -R samples examples ${D}/usr/share/doc/${PF}
	dohtml doc/api-documentation/html/*
}

pkg_postinst() {
	einfo ""
	einfo "To install modules for SWORD, you can emerge:"
	einfo "  app-text/sword-modules"
	einfo "or check out http://www.crosswire.org/sword/modules/"
	einfo "to download modules manually that you would like to"
	einfo "use the library with.  Follow module installation"
	einfo "instructions found on the web or in INSTALL.gz found"
	einfo "in /usr/share/doc/${PF}"
	einfo ""
}
