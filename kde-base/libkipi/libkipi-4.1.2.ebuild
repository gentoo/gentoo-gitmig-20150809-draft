# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkipi/libkipi-4.1.2.ebuild,v 1.1 2008/10/02 10:48:42 jmbsvicetto Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE=libs/libkipi

inherit kde4-meta

DESCRIPTION="A library for image plugins accross KDE applications"
HOMEPAGE="http://www.kipi-plugins.org/"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="!kdeprefix? ( !media-libs/libkipi )"
RDEPEND="${DEPEND}"
