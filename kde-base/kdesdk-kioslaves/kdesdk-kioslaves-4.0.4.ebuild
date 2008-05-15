# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-4.0.4.ebuild,v 1.1 2008/05/15 23:23:39 ingmar Exp $

EAPI="1"

KMNAME=kdesdk
KMMODULE=kioslave
inherit kde4-meta

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/apr
		dev-util/subversion"
RDEPEND="${RDEPEND}"

pkg_setup() {
	if ldd /usr/bin/svn | grep -q libapr-0 \
		&& ! has_version dev-libs/apr:0;
	then
		eerror "Subversion has been built against dev-libs/apr:0, but no matching version is installed."
		die "Please rebuild dev-util/subversion."
	fi
	if ldd /usr/bin/svn | grep -q libapr-1 \
		&& ! has_version dev-libs/apr:1;
	then
		eerror "Subversion has been built against dev-libs/apr:1, but no matching version is installed."
		die "Please rebuild dev-util/subversion."
	fi
}

src_compile() {
	if ldd /usr/bin/svn | grep -q libapr-0; then
		mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-config"
	else
		mycmakeargs="${mycmakeargs} -DAPRCONFIG_EXECUTABLE=/usr/bin/apr-1-config"
	fi

	kde4-meta_src_compile
}
