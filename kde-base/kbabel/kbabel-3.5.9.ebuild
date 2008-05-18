# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbabel/kbabel-3.5.9.ebuild,v 1.4 2008/05/18 18:50:28 maekke Exp $

KMNAME=kdesdk
EAPI="1"
inherit db-use kde-meta eutils

DESCRIPTION="KBabel - An advanced PO file editor"
KEYWORDS="~alpha amd64 ~hppa ~ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="berkdb kdehiddenvisibility"

DEPEND="berkdb? ( =sys-libs/db-4* )"

src_compile() {
	local myconf=""

	if use berkdb; then
		myconf="${myconf} --with-berkeley-db --with-db-lib=$(db_libname)
			--with-extra-includes=$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
