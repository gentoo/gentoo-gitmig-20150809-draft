# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbabel/kbabel-3.5.2.ebuild,v 1.6 2006/05/30 05:09:37 josejx Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KBabel - An advanced PO file editor"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="berkdb"

DEPEND="sys-devel/flex
	berkdb? ( || ( =sys-libs/db-4.3*
	               =sys-libs/db-4.2* ) )"

src_compile() {
	local myconf=""

	if use berkdb; then
		if has_version "=sys-libs/db-4.3*"; then
			myconf="${myconf} --with-berkeley-db --with-db-name=db-4.3
			        --with-db-include-dir=/usr/include/db4.3"
		elif has_version "=sys-libs/db-4.2*"; then
			myconf="${myconf} --with-berkeley-db --with-db-name=db-4.2
			        --with-db-include-dir=/usr/include/db4.2"
		fi
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
