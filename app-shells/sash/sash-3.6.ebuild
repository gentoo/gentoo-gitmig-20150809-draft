# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/sash/sash-3.6.ebuild,v 1.5 2003/12/17 03:43:39 brad_mssw Exp $

IUSE="readline"

S=${WORKDIR}/${P}
DESCRIPTION="A small static UNIX Shell with readline support"
SRC_URI="http://www.canb.auug.org.au/~dbell/programs/${P}.tar.gz"
HOMEPAGE="http://www.canb.auug.org.au/~dbell/ http://dimavb.st.simbirsk.su/vlk/"
SLOT="0"
LICENSE="freedist"

DEPEND="virtual/glibc
	>=sys-libs/zlib-1.1.4
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"

RDEPEND=""
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64 ppc64"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}

	epatch ${FILESDIR}/sash-3.6-fix-includes.patch

	if [ "`use readline`" ]
	then
		epatch ${FILESDIR}/sash-3.6-readline.patch
	fi

	sed -e "s:-O3:${CFLAGS}:" -i Makefile

}

src_compile() {
	make || die
}

src_install() {
	into /
	dobin sash
	into /usr
	doman sash.1
	dodoc README
}
