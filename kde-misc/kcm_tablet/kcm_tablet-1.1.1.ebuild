# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcm_tablet/kcm_tablet-1.1.1.ebuild,v 1.3 2009/12/28 23:44:21 ssuominen Exp $

EAPI=2
inherit kde4-base

MY_P=kcm_tablet-kcm_tablet

DESCRIPTION="KControl module for wacom tablets"
HOMEPAGE="http://kde-apps.org/content/show.php?action=content&content=114856"
SRC_URI="http://kde-apps.org/CONTENT/content-files/114856-${MY_P}-master.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DEPEND="!<x11-drivers/xf86-input-wacom-0.10.3"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS README"
