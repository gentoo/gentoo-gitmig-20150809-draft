# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.7.ebuild,v 1.6 2007/08/10 16:08:17 angelos Exp $

KMNAME=kdebase
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="pam kdehiddenvisibility"
DEPEND="pam? ( kde-base/kdebase-pam )"

src_compile() {
	myconf="$(use_with pam)"

	export BINDNOW_FLAGS="$(bindnow-flags)"
	kde-meta_src_compile
}
