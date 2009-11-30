# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sword/sword-1.6.0.ebuild,v 1.3 2009/11/30 12:56:20 maekke Exp $

inherit flag-o-matic

DESCRIPTION="Library for Bible reading software."
HOMEPAGE="http://www.crosswire.org/sword/"
SRC_URI="http://www.crosswire.org/ftpmirror/pub/sword/source/v1.6/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE="curl debug doc icu lucene"

RDEPEND="sys-libs/zlib
	curl? ( net-misc/curl )
	icu? ( dev-libs/icu )
	lucene? ( dev-cpp/clucene )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	strip-flags
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
	if use doc ;then
		rm -rf examples/.cvsignore
		rm -rf examples/cmdline/.cvsignore
		rm -rf examples/cmdline/.deps
		cp -R samples examples "${D}/usr/share/doc/${PF}/"
	fi
	# global configuration file
	insinto /etc
	doins "${FILESDIR}/sword.conf"
}

pkg_postinst() {
	echo
	elog "Check out http://www.crosswire.org/sword/modules/"
	elog "to download modules that you would like to use with SWORD."
	elog "Follow module installation instructions found on"
	elog "the web or in /usr/share/doc/${PF}/"
	echo
}
