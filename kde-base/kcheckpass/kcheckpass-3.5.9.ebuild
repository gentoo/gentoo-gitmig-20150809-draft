# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.9.ebuild,v 1.5 2008/05/12 21:28:06 jer Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-06.tar.bz2"

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="pam kdehiddenvisibility"
DEPEND="pam? ( kde-base/kdebase-pam )"

src_compile() {
	myconf="$(use_with pam)"

	kde-meta_src_compile
}
