# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncenter/burncenter-3.2.1.ebuild,v 1.5 2007/04/23 18:21:27 armin76 Exp $

DESCRIPTION="A Perl module and a collection of easy-to-use text based interfaces to the UNIX CD burning tools"
HOMEPAGE="http://alx14.free.fr/burncenter/"
SRC_URI="http://alx14.free.fr/burncenter/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="vorbis"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	virtual/cdrtools
	virtual/mpg123
	vorbis? (
		>=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"


src_compile() {
	# Nothing to do.
	true
}

src_install() {
	local modulePath=$(perl -V:installprivlib | perl -p -e "s/^.*?='(.*?)';/\$1/")
	dobin burncenter
	dobin bcbatch
	insinto ${modulePath}
	doins Burncenter.pm

	dodoc COPYING DEVELOP-FRONTENDS README TODO
}
