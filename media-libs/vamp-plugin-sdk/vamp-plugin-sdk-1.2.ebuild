# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vamp-plugin-sdk/vamp-plugin-sdk-1.2.ebuild,v 1.2 2008/04/13 21:04:03 aballier Exp $

inherit toolchain-funcs eutils multilib

DESCRIPTION="Audio processing plugin system for plugins that extract descriptive information from audio data"
HOMEPAGE="http://www.vamp-plugins.org"
SRC_URI="mirror://sourceforge/vamp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="media-libs/libsndfile"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# multilib for default search paths
	sed -i -e "s:/usr/lib/vamp:/usr/$(get_libdir)/vamp:" vamp-sdk/PluginHostAdapter.cpp
	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
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
