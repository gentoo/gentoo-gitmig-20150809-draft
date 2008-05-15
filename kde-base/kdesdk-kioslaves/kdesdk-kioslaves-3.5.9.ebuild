# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-3.5.9.ebuild,v 1.3 2008/05/15 16:06:06 corsair Exp $

KMNAME=kdesdk
KMMODULE=kioslave
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kioslaves from kdesdk package: the subversion kioslave"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ppc64 ~sparc ~x86"
IUSE="kdehiddenvisibility"
DEPEND="dev-util/subversion"

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
		myconf="--with-apr-config=/usr/bin/apr-config
		--with-apu-config=/usr/bin/apu-config"
	else
		myconf="--with-apr-config=/usr/bin/apr-1-config
		--with-apu-config=/usr/bin/apu-1-config"
	fi
	kde-meta_src_compile
}
