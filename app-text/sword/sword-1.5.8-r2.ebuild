# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.8-r2.ebuild,v 1.5 2008/05/21 12:51:33 drac Exp $

inherit flag-o-matic

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/source/v1.5/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="curl icu debug"

RDEPEND="sys-libs/zlib
	curl? ( net-misc/curl )
	icu? ( dev-libs/icu )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/escape_range.patch"
}

src_compile() {
	strip-flags
	local myconf="--without-lucene --with-zlib --with-conf
	              $(use_enable debug) $(use_with curl)"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CODINGSTYLE ChangeLog INSTALL README

	cp -R samples examples "${D}/usr/share/doc/${PF}/"
}

pkg_postinst() {
	echo
	elog "Check out http://www.crosswire.org/sword/modules/"
	elog "to download modules that you would like to use with SWORD."
	elog "Follow module installation instructions found on"
	elog "the web or in /usr/share/doc/${PF}/INSTALL.gz."
	echo
}
