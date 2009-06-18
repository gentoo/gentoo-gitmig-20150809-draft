# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kandy/kandy-3.5.10-r1.ebuild,v 1.3 2009/06/18 04:52:24 jer Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	 mirror://gentoo/kandy-icons.tar.bz2"

DESCRIPTION="KDE: Communicating with your mobile phone"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkdepim-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkdepim libkdepim"
KMEXTRACTONLY="
	libkdepim/ "

src_install() {
	kde_src_install

	for file in "${WORKDIR}"/kandy-icons/*; do
		insinto "${KDEDIR}"/share/icons/hicolor/${file##*/}/apps
		doins "${WORKDIR}"/kandy-icons/${file##*/}/kandy.png
	done
}
