# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kpresenter/kpresenter-2.1.0.ebuild,v 1.2 2009/12/17 10:35:20 ssuominen Exp $

EAPI="2"

KMNAME="koffice"
KMMODULE="${PN}"
inherit kde4-meta

DESCRIPTION="KOffice presentation program."

KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/boost-1.35.0"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="libs/"
KMEXTRA="filters/${KMMODULE}/"

KMLOADLIBS="koffice-libs"
