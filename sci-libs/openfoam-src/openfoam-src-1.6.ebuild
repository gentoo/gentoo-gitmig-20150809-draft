# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openfoam-src/openfoam-src-1.6.ebuild,v 1.2 2009/09/25 09:30:00 flameeyes Exp $

EAPI="2"

inherit eutils versionator multilib

MY_PN="OpenFOAM"
MY_PV=$(get_version_component_range 1-2)
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="OpenFOAM - sources"
HOMEPAGE="http://www.opencfd.co.uk/openfoam/"
SRC_URI="mirror://sourceforge/foam/${MY_P}.General.gtgz -> ${MY_P}.General.tgz
	mirror://gentoo/${MY_P}-compile.patch.bz2"

LICENSE="GPL-2"
SLOT="1.6"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( =sci-libs/openfoam-meta-${MY_PV}* =sci-libs/openfoam-${MY_PV}* =sci-libs/openfoam-bin-${MY_PV}* )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
INSDIR="/usr/$(get_libdir)/${MY_PN}/${MY_P}"

src_prepare() {
	epatch "${DISTDIR}"/${MY_P}-compile.patch.bz2
}

src_install() {
	insinto ${INSDIR}/src
	doins -r src/*

	insinto ${INSDIR}/applications
	doins -r applications/*
}
