# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gscmxx/gscmxx-0.4.1.ebuild,v 1.1 2003/03/22 04:30:11 pylon Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A frontend for scmxx (exchange data with Siemens phones)."
HOMEPAGE="http://gscmxx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}"
RDEPEND=">=app-misc/scmxx-0.6
	>=dev-lang/perl-5.005
	>=dev-perl/gtk-perl-0.7008
	>=x11-libs/gtk+-1.2.8
	>=dev-perl/ImageSize-2.92
	media-gfx/imagemagick"
