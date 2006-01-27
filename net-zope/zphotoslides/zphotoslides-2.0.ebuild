# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zphotoslides/zphotoslides-2.0.ebuild,v 1.2 2006/01/27 02:53:18 vapier Exp $

inherit zproduct

DESCRIPTION="Present your photos quickly in zope"
HOMEPAGE="http://www.zphotoslides.org/"
SRC_URI="mirror://sourceforge/zphotoslides/ZPhotoSlides-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

RDEPEND=">=dev-python/imaging-1.1.3
	>=net-zope/localfs-1.0.0"

ZPROD_LIST="ZPhotoSlides"
