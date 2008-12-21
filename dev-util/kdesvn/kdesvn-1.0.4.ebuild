# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdesvn/kdesvn-1.0.4.ebuild,v 1.3 2008/12/21 10:35:18 george Exp $

inherit qt3 kde-functions versionator

My_PV=$(get_version_component_range 1-2)

DESCRIPTION="KDESvn is a frontend to the subversion vcs."
HOMEPAGE="http://www.alwins-world.de/wiki/programs/kdesvn"
SRC_URI="http://kdesvn.alwins-world.de/trac.fcgi/downloads/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-util/subversion-1.4
	=kde-base/kdesdk-kioslaves-3.5*
	dev-db/sqlite"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4"

need-kde 3.3

LANGS="ca cs de es fr gl it ja lt nl pa ru sv"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} || rm -f "${X}."*
	done

	# this seems to be again necessary
	sed -i -e "s:\${APR_CPP_FLAGS}:\${APR_CPP_FLAGS} \"-DQT_THREAD_SUPPORT\":" \
		"${S}"/CMakeLists.txt || die "QT_THREAD_SUPPORT sed failed"

	# Force kdesvn to recognize kio_svn protocol name instead of kio_ksvn
	# (this way we can reuse .protocol files from kdesdk-kioslaves, avoiding
	# collision)
	grep -rle "kio_ksvn" "${S}"/* | xargs \
		sed -i -e "s:kio_ksvn:kio_svn:"
}

src_compile() {
	local myconf
	if use debug ; then
		myconf="-DCMAKE_BUILD_TYPE=Debug"
	fi

	set-kdedir

	cmake \
		-DCMAKE_INSTALL_PREFIX=${KDEDIR} \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER=$(type -P $(tc-getCC)) \
		-DCMAKE_CXX_COMPILER=$(type -P $(tc-getCXX)) \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DQT_THREAD_SUPPORT" \
		-DLIB_INSTALL_DIR=/usr/$(get_libdir) \
		${myconf} || die

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# remove svn*.protocol files, now that they provide the same stuff as the
	# ones by kdesdk-kioslaves
	rm "${D}/${KDEDIR}"/share/services/svn*.protocol
}

pkg_postinst() {
	if ! has_version 'kde-base/kompare'; then
		echo
		elog "For nice graphical diffs, install kde-base/kompare."
		echo
	fi
}
