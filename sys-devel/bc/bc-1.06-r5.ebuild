# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bc/bc-1.06-r5.ebuild,v 1.2 2003/02/20 10:11:10 zwelch Exp $

IUSE="readline"

inherit flag-o-matic

S="${WORKDIR}/${P}"
DESCRIPTION="Handy console-based calculator utility"
SRC_URI="ftp://prep.ai.mit.edu/pub/gnu/bc/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"

LICENSE="GPL-2 & LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa arm"

RDEPEND="readline? ( >=sys-libs/readline-4.1 
	>=sys-libs/ncurses-5.2 )"
DEPEND="$RDEPEND sys-devel/flex"

src_unpack() {

	unpack ${A} ; cd ${S}

	patch -p1 < ${FILESDIR}/bc-1.06-info-fix.diff || die
	patch -p1 < ${FILESDIR}/bc-1.06-readline42.diff || die

	# Command line arguments for flex changed from the old
	# 2.5.4 to 2.5.22, so fix configure if we are using the
	# new flex.  Note that flex-2.5.4 prints 'flex version 2.5.4'
	# and flex-2.5.22 prints 'flex 2.5.22', bug #10546.
	# <azarah@gentoo.org> (23 Oct 2002)
	local flmajor="`flex --version | cut -d. -f1`"
	local flminor="`flex --version | cut -d. -f2`"
	local flmicro="`flex --version | cut -d. -f3`"
	if [ "${flmajor/flex* }" -ge 2 -a \
	     "${flminor/flex* }" -ge 5 -a \
	     "${flmicro/flex* }" -ge 22 ]
	then
		cd ${S}; cp configure configure.orig
		sed -e 's:flex -I8:flex -I:g' \
			configure.orig > configure
	fi
}

src_compile() {

	# -O2 causes segafults on ppc with zero backtrace :/
	use ppc && filter-flags "-O2"
	local myconf=""
	use readline && myconf="--with-readline"

	econf ${myconf} || die

	emake || die
}

src_install() {

	into /usr
	dobin bc/bc dc/dc

	doinfo doc/*.info
	doman doc/*.1
	dodoc AUTHORS COPYING* FAQ NEWS README ChangeLog
}

