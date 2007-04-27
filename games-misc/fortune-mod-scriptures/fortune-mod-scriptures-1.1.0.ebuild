# Copyright 2006-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-scriptures/fortune-mod-scriptures-1.1.0.ebuild,v 1.3 2007/04/27 02:19:43 beandog Exp $

DESCRIPTION="Fortune modules from the King James Bible scriptures"
HOMEPAGE="http://scriptures.nephi.org/"
SRC_URI="mirror://sourceforge/mormon/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND="games-misc/fortune-mod"

src_install() {
	dodoc README ChangeLog
	insinto /usr/share/fortune
	doins mods/*
}

pkg_postinst() {
	elog "This package contains twelve fortune modules:"
	elog "acts - The Acts of the Apostles"
	elog "bible - King James Version of the Holy Bible"
	elog "eccl - Ecclesiastes"
	elog "epistles - New Testament Epistles (Romans to Jude)"
	elog "gospels - The Four Gospels (Matthew, Mark, Luke, John)"
	elog "isaiah - The Book of Isaiah"
	elog "nt - The New Testament"
	elog "ot - The Old Testament"
	elog "proverbs - Proverbs"
	elog "psalms - Psalms"
}
