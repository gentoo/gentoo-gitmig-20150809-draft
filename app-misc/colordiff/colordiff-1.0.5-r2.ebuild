# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.5-r2.ebuild,v 1.6 2005/08/09 11:58:40 ka0ttic Exp $

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/colordiff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 mips ppc ~ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="sys-apps/diffutils"

src_compile() {
	# Version 1.0.5 removed the --no-banner option.  Few other programs show
	# such information without requesting it, so make it default to off
	sed -i -e 's/^banner=.*/banner=no/' colordiffrc*

	# Make "plain" be the default foreground color instead of forcing black or
	# white.
	# NB: By default colordiff-1.0.5 lowercases config values, so we need to
	# lowercase OFF in the executable as well
	sed -i -e 's/^plain=.*/plain=off/' colordiffrc*
	sed -i -e 's/\<OFF\>/off/g' colordiff.pl
}

src_install() {
	newbin colordiff.pl colordiff cdiff.sh cdiff || die
	insinto /etc
	doins colordiffrc colordiffrc-lightbg
	dodoc BUGS CHANGES README TODO
	doman colordiff.1
}
