# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.8_pre1.ebuild,v 1.8 2005/07/27 21:19:12 greg_g Exp $

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"

LICENSE="GPL-2"
SLOT="0"
# cvs snapshot required as all other versions are broken
KEYWORDS="x86 ppc amd64"
SRC_URI="http://dev.gentoo.org/~squinky86/files/${P}.tar.bz2"
IUSE="icu curl"
RDEPEND="virtual/libc
	sys-libs/zlib
	curl? ( >=net-misc/curl-7.10.8 )
	icu? ( dev-libs/icu )"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.2"

src_compile() {
	export WANT_AUTOMAKE="1.6"
	cd ${S}
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "autogen.sh failed"
	econf --without-clucene --without-lucene `use_with icu` `use_with curl` || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall || die "install failed"
	dodir /etc
	insinto /etc
	doins ${FILESDIR}/sword.conf

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
