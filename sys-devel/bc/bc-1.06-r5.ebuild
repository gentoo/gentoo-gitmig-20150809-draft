# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bc/bc-1.06-r5.ebuild,v 1.12 2003/12/17 04:13:58 brad_mssw Exp $

IUSE="readline"

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Handy console-based calculator utility"
HOMEPAGE="http://www.gnu.org/software/bc/bc.html"
SRC_URI="mirror://gnu/bc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha hppa arm mips amd64 ia64 ppc64"

RDEPEND="readline? ( >=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2 )"
DEPEND="$RDEPEND
	>=sys-apps/portage-2.0.47-r10
	sys-devel/flex"

src_unpack() {

	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/bc-1.06-info-fix.diff
	epatch ${FILESDIR}/bc-1.06-readline42.diff

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

	# -Os causes segfaults on x86
	use x86 && replace-flags "-Os" "-O2"

	# >= -O2 crashes bc -l and -O1 produces no output
	use amd64 && replace-flags "-O[1-9]" "-O0"

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

