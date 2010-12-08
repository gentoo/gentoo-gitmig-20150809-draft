# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.98.ebuild,v 1.1 2010/12/08 16:55:07 scarabeus Exp $

EAPI=3

KMNAME="extragear/network"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="bg da de en_GB es et fr ja nb nds nl pa pl pt pt_BR sv tr uk zh_CN zh_TW"
	SRC_URI="http://choqok.gnufolks.org/pkgs/${PN}_${PV}.tar.bz2"
fi

inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug +handbook"

DEPEND="dev-libs/qjson
		>=dev-libs/qoauth-1.0.1"
RDEPEND="${DEPEND}"
