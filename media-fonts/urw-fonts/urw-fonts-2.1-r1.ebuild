# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/urw-fonts/urw-fonts-2.1-r1.ebuild,v 1.2 2004/06/24 22:32:08 agriffis Exp $

inherit eutils rpm font

DESCRIPTION="free good quality fonts gpl'd by URW++"
HOMEPAGE=""
SRC_URI="ftp://rpmfind.net/linux/fedora/core/development/SRPMS/${P}-7.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

#DEPEND="app-arch/rpm2targz"
#DEPEND comes from rpm.eclass

S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="afm pfb"
DOCS="ChangeLog README* TODO"
