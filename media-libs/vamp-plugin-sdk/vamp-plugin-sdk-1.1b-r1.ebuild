# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vamp-plugin-sdk/vamp-plugin-sdk-1.1b-r1.ebuild,v 1.5 2007/11/25 02:40:57 ranger Exp $

inherit toolchain-funcs eutils multilib

DESCRIPTION="Audio processing plugin system for plugins that extract descriptive information from audio data"
HOMEPAGE="http://www.vamp-plugins.org"
SRC_URI="mirror://sourceforge/vamp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="media-libs/libsndfile"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}-v${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-destdir.patch"
	epatch "${FILESDIR}/${P}-dirsearch.patch"
	# multilib for default search paths
	sed -i -e "s:/usr/lib/vamp:/usr/$(get_libdir)/vamp:" vamp-sdk/PluginHostAdapter.cpp
}

src_compile() {
	tc-export CXX
	emake || die "emake failed"
	if use doc; then
		doxygen || die "creating doxygen doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" INSTALL_SDK_LIBS="/usr/$(get_libdir)" INSTALL_PKGCONFIG="/usr/$(get_libdir)/pkgconfig" install || die "emake install failed"
	dodoc README
	insinto /usr/$(get_libdir)/vamp
	doins examples/vamp-example-plugins{.so,.cat}
	dobin host/vamp-simple-host
	use doc && dohtml -r doc/html/*
}

pkg_postinst() {
	elog ""
	elog "You might also want to install some Vamp plugins."
	elog "See media-plugins/vamp-*"
	elog ""
}
