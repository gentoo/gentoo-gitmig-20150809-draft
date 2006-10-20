# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-scriptures/fortune-mod-scriptures-1.1.0.ebuild,v 1.1 2006/10/20 19:11:45 beandog Exp $

DESCRIPTION="Fortune modules from the King James Bible scriptures"
HOMEPAGE="http://scriptures.nephi.org/"
SRC_URI="mirror://sourceforge/mormon/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND="games-misc/fortune-mod"

src_install() {
	dodoc README ChangeLog
	insinto /usr/share/fortune
	doins mods/*
}

pkg_postinst() {
	einfo "This package contains twelve fortune modules:"
	einfo "acts - The Acts of the Apostles"
	einfo "bible - King James Version of the Holy Bible"
	einfo "eccl - Ecclesiastes"
	einfo "epistles - New Testament Epistles (Romans to Jude)"
	einfo "gospels - The Four Gospels (Matthew, Mark, Luke, John)"
	einfo "isaiah - The Book of Isaiah"
	einfo "nt - The New Testament"
	einfo "ot - The Old Testament"
	einfo "proverbs - Proverbs"
	einfo "psalms - Psalms"
}
