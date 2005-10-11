# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-slackware/fortune-mod-slackware-1.10.ebuild,v 1.1 2005/10/11 07:17:28 mr_bones_ Exp $

MY_PN=slack-fortunes-all
DESCRIPTION="This fortune mod is a collection of quotes seen on AOLS (Slackware)"
HOMEPAGE="http://fauxascii.com/linux/mod_quotes.html"
SRC_URI="http://fauxascii.com/linux/data/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="games-misc/fortune-mod"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -f *.md5
}

src_install() {
	insinto /usr/share/fortune
	doins * || die "doins failed"
}
