# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.5.9.ebuild,v 1.1 2006/10/21 17:09:55 squinky86 Exp $

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/source/v1.5/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="curl debug icu lucene"

RDEPEND="sys-libs/zlib
	curl? ( net-misc/curl )
	icu? ( dev-libs/icu )
	lucene? ( dev-cpp/clucene )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="--without-lucene --with-zlib --with-conf
	              $(use_enable debug) $(use_with curl)"

	econf --with-zlib \
		--with-conf \
		$(use_enable curl) \
		$(use_enable debug) \
		$(use_with icu) \
		$(use_enable lucene) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CODINGSTYLE ChangeLog INSTALL README

	cp -R samples examples ${D}/usr/share/doc/${PF}/
}

pkg_postinst() {
	echo
	einfo "Check out http://www.crosswire.org/sword/modules/"
	einfo "to download modules that you would like to use with SWORD."
	einfo "Follow module installation instructions found on"
	einfo "the web or in /usr/share/doc/${PF}/INSTALL.gz."
	echo
}
