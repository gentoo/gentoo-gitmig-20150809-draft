# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.2.8.ebuild,v 1.5 2009/01/06 02:48:08 ranger Exp $

inherit kde

MY_P="${P/_/}"
MY_PV="${PV/_/}"
DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"
SRC_URI="http://ktorrent.org/downloads/${MY_PV}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="avahi kdeenablefinal"

DEPEND="dev-libs/gmp
	>=dev-libs/geoip-1.4.0-r1
	avahi? ( >=net-dns/avahi-0.6.16-r1 )"
RDEPEND="${DEPEND}
	|| ( =kde-base/kdebase-kioslaves-3.5* =kde-base/kdebase-3.5* )"

S="${WORKDIR}/${MY_P}"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et fa fr gl hu it ja ka lt
ms nb nds nl pa pl pt pt_BR ru rw sk sr sr@Latn sv tr uk zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi qt3 ; then
		echo
		eerror "In order to use ktorrents zeroconf plugin you need to have"
		eerror "net-dns/avahi emerged with \"qt3\" in your USE flag. Please add"
		eerror "that flag, re-emerge avahi, and then emerge ktorrent again."
		echo
		die "net-dns/avahi not built with \"qt3\" support."
	fi

	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${MY_P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am

	cd "${S}"
	# Fix automagic dependencies on avahi
	epatch "${FILESDIR}/${PN}-2.2.5-avahi-check.patch"

	rm -f "${S}/configure"
}

src_compile(){
	local myconf="${myconf}
		$(use_with avahi)
		--enable-builtin-country-flags
		--enable-knetwork
		--enable-system-geoip
		--enable-torrent-mimetype
		--disable-geoip"

	kde_src_compile
}
