# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.2.2.ebuild,v 1.1 2007/09/01 15:15:18 philantrop Exp $

inherit kde

MY_P="${P/_/}"
MY_PV="${PV/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"
SRC_URI="http://ktorrent.org/downloads/${MY_PV}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi geoip kdeenablefinal"

DEPEND="dev-libs/gmp
		avahi? ( >=net-dns/avahi-0.6.16-r1 )
		geoip? ( >=dev-libs/geoip-1.4.0-r1 )"
RDEPEND="${DEPEND}"

need-kde 3.5

LANGS="ar bg br ca cs cy da de el en_GB es et fa fr gl hu it ja ka lt
ms nb nds nl pa pl pt pt_BR ru rw sk sr sr@Latn sv tr uk zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	local MAKE_LANGS
	cd "${WORKDIR}/${MY_P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am

	cd "${S}"
	# Fix automagic dependencies on avahi and geoip
	epatch "${FILESDIR}/${P}-avahi-check.patch"
	epatch "${FILESDIR}/${P}-geoip-check.patch"

	rm -f "${S}/configure"
}

src_compile(){
	local myconf="--enable-knetwork --enable-builtin-country-flags"
	myconf="${myconf} --enable-torrent-mimetype"

	if use geoip ; then
		myconf="${myconf} --enable-system-geoip --disable-geoip"
	else
		myconf="${myconf} --disable-geoip --disable-system-geoip"
	fi

	if use avahi ; then
		myconf="${myconf} --with-avahi"
	else
		myconf="${myconf} --without-avahi"
	fi

	kde_src_compile
}
