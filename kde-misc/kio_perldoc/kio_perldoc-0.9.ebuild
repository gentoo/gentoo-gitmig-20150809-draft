# Copyright 2008-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio_perldoc/kio_perldoc-0.9.ebuild,v 1.6 2009/01/04 15:40:42 scarabeus Exp $

EAPI="2"
NEED_KDE="4.1"
inherit kde4-base

DESCRIPTION="Kio slave to search perldoc"
HOMEPAGE="http://www.purinchu.net/wp/2007/12/01/kio_perldoc/"
SRC_URI="http://www.purinchu.net/dumping-ground/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0"

PATCHES=( "${FILESDIR}/${P}-kdeexport.patch" )
