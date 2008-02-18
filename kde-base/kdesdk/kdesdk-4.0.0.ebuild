# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-4.0.0.ebuild,v 1.2 2008/02/18 22:53:47 zlin Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook subversion"
LICENSE="GPL-2 LGPL-2"

DEPEND="dev-libs/libxml2
	dev-libs/libxslt
	|| ( >=kde-base/plasma-${PV}:${SLOT}
		>=kde-base/kdebase-${PV}:${SLOT} )
	subversion? ( dev-libs/apr dev-util/subversion )"
RDEPEND="${DEPEND}
	dev-util/cvs
	media-gfx/graphviz"

pkg_setup() {
	if use subversion ; then
		if ldd /usr/bin/svn | grep -q libapr-0 \
			&& ! has_version dev-libs/apr:0;
		then
			eerror "Subversion has been built against =dev-libs/apr-0*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
		if ldd /usr/bin/svn | grep -q libapr-1 \
			&& ! has_version dev-libs/apr:1;
		then
			eerror "Subversion has been built against =dev-libs/apr-1*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
	fi

	kde4svn_pkg_setup
}

src_compile() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with subversion SVN)"

	if use subversion; then
		if ldd /usr/bin/svn | grep -q libapr-0; then
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
		else
			mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
		fi
	fi

	kde4-base_src_compile
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "To make full use of ${PN} you should emerge >=dev-util/valgrind-3.2.0 and/or"
	elog "dev-util/oprofile."
	echo
}
