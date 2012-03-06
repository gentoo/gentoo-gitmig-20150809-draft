# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-4.8.1.ebuild,v 1.1 2012/03/06 23:35:13 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE CD player"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/musicbrainz:3
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.7.3-underlinking.patch" )

KMEXTRACTONLY="
	libkcompactdisc/
"

src_unpack() {
	use handbook && KMEXTRA="doc/kcontrol/cddbretrieval"

	kde4-meta_src_unpack
}
