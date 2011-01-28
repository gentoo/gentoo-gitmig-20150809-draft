# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kabcclient/kabcclient-4.4.10.ebuild,v 1.2 2011/01/28 05:20:43 tampakrap Exp $

EAPI="3"

KMNAME="kdepim"
KMMODULE="console/${PN}"
inherit kde4-meta

DESCRIPTION="A command line client for accessing the KDE addressbook"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

src_install() {
	kde4-meta_src_install

	# work around NULL DT_RPATH in kabc2mutt
	dosym kabcclient ${PREFIX}/bin/kabc2mutt || die "couldn't symlink kabc2mutt to kabcclient"
}
