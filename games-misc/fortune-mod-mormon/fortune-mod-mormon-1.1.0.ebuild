# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-mormon/fortune-mod-mormon-1.1.0.ebuild,v 1.4 2007/04/27 02:22:38 beandog Exp $

DESCRIPTION="Fortune modules from the LDS scriptures (KJV Bible, Book of Mormon,
D&C, PGP)"
HOMEPAGE="http://scriptures.nephi.org/"
SRC_URI="mirror://sourceforge/mormon/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86
~x86-fbsd"
IUSE=""
RDEPEND="games-misc/fortune-mod
	games-misc/fortune-mod-scriptures"
SLOT="0"

src_install() {
	dodoc ChangeLog README
	insinto /usr/share/fortune
	doins mods/dc mods/dc.dat mods/mormon mods/mormon.dat mods/pgp
	doins mods/scriptures.dat mods/scriptures mods/aof.dat mods/aof
}

pkg_postinst() {
	elog "This package contains four fortune modules:"
	elog "aof - The Articles of Faith"
	elog "dc - Doctrine and Covenants"
	elog "mormon - The Book of Mormon"
	elog "pgp - The Pearl of Great Price"
	elog "scriptures - All above plus KJV Bible"
}
