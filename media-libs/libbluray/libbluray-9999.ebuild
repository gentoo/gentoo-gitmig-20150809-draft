# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray/libbluray-9999.ebuild,v 1.3 2011/02/01 12:52:58 radhermit Exp $

EAPI=2

inherit autotools java-pkg-opt-2 git flag-o-matic

EGIT_REPO_URI="git://git.videolan.org/libbluray.git"

DESCRIPTION="Blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aacs java static-libs utils xine"

COMMON_DEPEND="dev-libs/libxml2
	xine? ( media-libs/xine-lib )"
RDEPEND="${COMMON_DEPEND}
	aacs? ( media-video/aacskeys )
	java? ( >=virtual/jre-1.6 )"
DEPEND="${COMMON_DEPEND}
	java? ( >=virtual/jdk-1.6 )
	dev-util/pkgconfig"

src_prepare() {
	use java && export JDK_HOME="$(java-config -g JAVA_HOME)"
	eautoreconf

	java-pkg-opt-2_src_prepare
}

src_configure() {
	local myconf=""
	if use java; then
		export JAVACFLAGS="$(java-pkg_javac-args)"
		append-cflags "$(java-pkg_get-jni-cflags)"
		myconf="--with-jdk=${JDK_HOME}"
	fi

	econf \
		$(use_enable java bdjava) \
		$(use_enable static-libs static) \
		$(use_enable utils static) \
		$(use_enable utils examples) \
		$myconf
}

src_compile() {
	emake || die

	if use xine; then
		cd player_wrappers/xine || die
		emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc doc/README README.txt TODO.txt || die

	if use utils; then
		cd src/examples/
		dobin clpi_dump index_dump mobj_dump mpls_dump sound_dump || die
		cd .libs/
		dobin bd_info bdsplice hdmv_test libbluray_test list_titles || die
		if use java; then
			dobin bdj_test || die
		fi
	fi

	if use java; then
		java-pkg_dojar "${S}/src/.libs/${PN}.jar"
		doenvd "${FILESDIR}"/90${PN}
	fi

	if use xine; then
		cd "${S}"/player_wrappers/xine || die
		emake DESTDIR="${D}" install || die
		newdoc HOWTO README.xine
	fi
}
