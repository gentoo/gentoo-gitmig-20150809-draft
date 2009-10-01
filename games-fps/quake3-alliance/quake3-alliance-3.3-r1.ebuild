# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-alliance/quake3-alliance-3.3-r1.ebuild,v 1.3 2009/10/01 21:15:10 nyhm Exp $

MOD_DESC="fast paced, off-handed grapple mod"
MOD_NAME="Alliance"
MOD_DIR="alliance"

inherit games games-mods

SRC_URI="http://mir2.ovh.net/ftp.planetquake3.net/modifications/alliance/alliance30.zip
	http://mir2.ovh.net/ftp.planetquake3.net/modifications/alliance/alliance30-33.zip"
HOMEPAGE="http://www.planetquake.com/alliance/"

LICENSE="freedist"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
