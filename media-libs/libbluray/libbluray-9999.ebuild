# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray/libbluray-9999.ebuild,v 1.4 2011/02/04 19:51:04 radhermit Exp $

EAPI=4

inherit autotools java-pkg-opt-2 git flag-o-matic

EGIT_REPO_URI="git://git.videolan.org/libbluray.git"

DESCRIPTION="Blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aacs java static-libs utils xine"

COMMON_DEPEND="
	dev-libs/libxml2
	xine? ( media-libs/xine-lib )
"
RDEPEND="
	${COMMON_DEPEND}
	aacs? ( media-video/aacskeys )
	java? ( >=virtual/jre-1.6 )
"
DEPEND="
	${COMMON_DEPEND}
	java? (
		>=virtual/jdk-1.6
		dev-java/ant-core
	)
	dev-util/pkgconfig
"

DOCS="doc/README README.txt TODO.txt"

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
	emake

	if use xine; then
		cd player_wrappers/xine
		emake
	fi
}

src_install() {
	default_src_install

	if use utils; then
		cd src/examples/
		dobin clpi_dump index_dump mobj_dump mpls_dump sound_dump
		cd .libs/
		dobin bd_info bdsplice hdmv_test libbluray_test list_titles
		if use java; then
			dobin bdj_test
		fi
	fi

	if use java; then
		java-pkg_dojar "${S}/src/.libs/${PN}.jar"
		doenvd "${FILESDIR}"/90${PN}
	fi

	if use xine; then
		cd "${S}"/player_wrappers/xine
		emake DESTDIR="${D}" install
		newdoc HOWTO README.xine
	fi
}
