# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-slackware/fortune-mod-slackware-1.15.ebuild,v 1.1 2007/11/03 23:21:49 tupone Exp $

# this ebuild now uses the offensive flag since AOLS
# is not exactly 'G' rated :)

MY_PN=slack-fortunes-all
DESCRIPTION="This fortune mod is a collection of quotes seen on AOLS (Slackware)"
HOMEPAGE="http://fauxascii.com/linux/mod_quotes.html"
SRC_URI="http://fauxascii.com/linux/data/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="offensive"

RDEPEND="games-misc/fortune-mod"

S=${WORKDIR}

pkg_setup() {
	if ! use offensive ; then
		elog "These fortunes have offensive content. Enable offensive USE Flag"
		elog "ex: USE=\"offensive\" emerge ${PN}"
		elog " or add to package.use file: games-misc/fortune-mod-slackware offensive"
		exit 1
	fi
}

src_unpack() {
	unpack ${A}
	# get rid of md5 checks and extraneous files and backups
	rm -f index.* *.md5 *~
}

src_install() {
	insinto /usr/share/fortune
	doins * || die "doins failed"
}
