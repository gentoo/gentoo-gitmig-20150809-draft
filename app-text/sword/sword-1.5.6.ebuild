# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.6.ebuild,v 1.5 2004/04/08 22:11:14 squinky86 Exp $

inherit eutils

DESCRIPTION="library for bible reading software"
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="ftp://ftp.crosswire.org/pub/sword/source/v1.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="curl"
DEPEND="virtual/glibc
	sys-libs/zlib
	curl? ( >=net-misc/curl-7.10.8 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-installmgr-gentoo.patch
}

src_compile() {
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall

	dodoc AUTHORS CODINGSTYLE INSTALL ChangeLog README
	cp -R samples examples ${D}/usr/share/doc/${PF}
	dohtml doc/api-documentation/html/*
}

pkg_postinst() {
	einfo ""
	einfo "Check out http://www.crosswire.org/sword/modules/"
	einfo "to download modules that you would like to enhance"
	einfo "the library with.  Follow module installation"
	einfo "instructions found on the web or in INSTALL.gz found"
	einfo "in /usr/share/doc/${PF}"
	einfo ""
}
