# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.0.ebuild,v 1.23 2006/09/03 14:10:29 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=3.5.4
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-01.tar.bz2"

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="pam"
DEPEND="pam? ( kde-base/kdebase-pam )"

src_compile() {
	myconf="$(use_with pam)"

	export BINDNOW_FLAGS="$(bindnow-flags)"
	kde-meta_src_compile
}
