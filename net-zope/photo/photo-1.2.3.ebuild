# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/photo/photo-1.2.3.ebuild,v 1.11 2006/01/27 02:40:29 vapier Exp $

inherit zproduct

DESCRIPTION="Zope product for managing photos and photo albums"
HOMEPAGE="http://www.zope.org/Members/rbickers/Photo"
SRC_URI="mirror://sourceforge/zopephoto/Photo-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc x86"

RDEPEND="dev-python/imaging
	media-gfx/imagemagick"

ZPROD_LIST="Photo"
MYDOC="FAQ.txt THANKS.txt UPGRADE.txt DEPENDENCIES.txt ${MYDOC}"
