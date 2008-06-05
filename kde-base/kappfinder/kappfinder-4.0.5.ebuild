# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kappfinder/kappfinder-4.0.5.ebuild,v 1.1 2008/06/05 21:06:08 keytoaster Exp $

EAPI="1"

KMNAME=kdebase
KMMODULE=apps/${PN}
inherit kde4-meta

DESCRIPTION="KDE tool that looks for well-known apps in your path and creates entries for them in the KDE menu"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=""
RDEPEND="${DEPEND}"

KMEXTRA="apps/doc/${PN}"
