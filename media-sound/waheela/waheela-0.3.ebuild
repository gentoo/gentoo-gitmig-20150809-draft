# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/waheela/waheela-0.3.ebuild,v 1.1 2011/01/09 10:37:48 dilfridge Exp $

EAPI=3

inherit kde4-base

MY_P=${P/-/_}

DESCRIPTION="Amarok Fullscreen Player"
HOMEPAGE="http://kde-apps.org/content/show.php?content=108863"
SRC_URI="http://linux.wuertz.org/dists/sid/main/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-sound/amarok:4"

S=${WORKDIR}/${PN}
