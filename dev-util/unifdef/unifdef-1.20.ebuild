# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/unifdef/unifdef-1.20.ebuild,v 1.2 2006/12/02 23:26:27 vapier Exp $

DESCRIPTION="remove #ifdef'ed lines from a file while otherwise leaving the file alone"
HOMEPAGE="http://freshmeat.net/projects/unifdef/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}/Debian

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ../README.Gentoo README
}
