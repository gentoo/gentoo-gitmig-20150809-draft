# Copyright 2008-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio_perldoc/kio_perldoc-0.9.ebuild,v 1.2 2008/06/17 17:21:55 mr_bones_ Exp $

EAPI="1"
NEED_KDE="4"
inherit kde4-base

DESCRIPTION="Kio slave to search perldoc"
HOMEPAGE="http://www.purinchu.net/wp/2007/12/01/kio_perldoc/"
SRC_URI="http://www.purinchu.net/dumping-ground/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="kde-4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0"

PATCHES=( "${FILESDIR}/${P}-kdeexport.patch" )
PREFIX="${KDEDIR}"

src_install() {
	kde4-base_src_install
	dodoc CHANGES || die 'dodoc CHANGES failed.'
}
