# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/burncenter/burncenter-3.0.ebuild,v 1.13 2005/12/26 15:45:52 lu_zero Exp $

DESCRIPTION="Easy-to-use text based interface to the UNIX CD burning tools"
HOMEPAGE="http://alx14.free.fr/burncenter/"
SRC_URI="http://alx14.free.fr/burncenter/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="vorbis"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-1.11
	virtual/mpg123
	vorbis? (
		>=media-sound/vorbis-tools-1.0_rc2
		>=media-sound/oggtst-0.0 )"

S=${WORKDIR}/burncenter3

src_compile() {
	# Nothing to do.
	true
}

src_install() {
	local modulePath=$(perl -V:installprivlib | \
		perl -p -e "s/^.*?='(.*?)';/\$1/")

	dobin burncenter || die

	insinto ${modulePath}
	doins Burncenter.pm

	dodoc doc/DEVELOP-FRONTENDS doc/README doc/TODO
}
