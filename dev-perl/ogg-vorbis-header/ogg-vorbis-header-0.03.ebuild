# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ogg-vorbis-header/ogg-vorbis-header-0.03.ebuild,v 1.15 2009/11/13 16:07:24 idl0r Exp $

MODULE_AUTHOR="DBP"
MY_PN=Ogg-Vorbis-Header
MY_P=${MY_PN}-${PV}

inherit perl-module

DESCRIPTION="This module presents an object-oriented interface to Ogg Vorbis Comments and Information"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

S=${WORKDIR}/${MY_P}
SRC_TEST="do"
MAKEOPTS="${MAKEOPTS} -j1"

DEPEND="dev-perl/Inline
	media-libs/libogg
	media-libs/libvorbis
	dev-lang/perl"
