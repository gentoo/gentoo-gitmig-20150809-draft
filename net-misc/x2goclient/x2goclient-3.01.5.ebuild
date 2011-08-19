# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x2goclient/x2goclient-3.01.5.ebuild,v 1.2 2011/08/19 09:55:55 voyageur Exp $

EAPI="3"
inherit qt4-r2 versionator

MAJOR_PV="$(get_version_component_range 1-2)"
FULL_PV="${MAJOR_PV}-$(get_version_component_range 3)"
DESCRIPTION="The X2Go Qt client"
HOMEPAGE="http://x2go.berlios.de"
SRC_URI="http://x2go.obviously-nice.de/deb/pool-lenny/${PN}/${PN}_${FULL_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cups ldap"

DEPEND="net-misc/nx
	net-print/cups
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${MAJOR_PV}

src_prepare() {
	use ldap ||	epatch "${FILESDIR}"/${P}-noldap.patch
}

src_install() {
	dobin ${PN}
	dodoc README

	# copying the icons
	insinto /usr/share/pixmaps/x2goclient
	doins icons/*
	insinto /usr/share/pixmaps/x2goclient/16x16
	doins icons/16x16/*
	insinto /usr/share/pixmaps/x2goclient/32x32
	doins icons/32x32/*
	insinto /usr/share/pixmaps/x2goclient/64x64
	doins icons/64x64/*
	insinto /usr/share/pixmaps/x2goclient/128x128
	doins icons/128x128/*
	insinto /usr/share/pixmaps/x2goclient/hildon
	doins icons/hildon/*

	make_desktop_entry ${PN} "X2go client" ${PN} "Network"
}
