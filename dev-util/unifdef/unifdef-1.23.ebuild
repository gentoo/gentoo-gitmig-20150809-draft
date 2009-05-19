# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/unifdef/unifdef-1.23.ebuild,v 1.1 2009/05/19 07:17:53 vapier Exp $

DESCRIPTION="remove #ifdef'ed lines from a file while otherwise leaving the file alone"
HOMEPAGE="http://freshmeat.net/projects/unifdef/"
SRC_URI="mirror://gentoo/${P}.tar.lzma"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 -sparc-fbsd -x86-fbsd"
IUSE=""

S=${WORKDIR}/${P}/Debian

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:\<getline\>:get_line:' */unifdef.c || die #270369
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ../README.Gentoo README
}
