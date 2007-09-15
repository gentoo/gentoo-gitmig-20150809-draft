# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/remind/remind-03.01.02.ebuild,v 1.2 2007/09/15 07:41:53 tove Exp $

MY_P=${P/_beta/-BETA-}

DESCRIPTION="Ridiculously functional reminder program"
HOMEPAGE="http://www.roaringpenguin.com/en/penguin/openSourceProducts/remind"
SRC_URI="http://www.roaringpenguin.com/files/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="tk"

RDEPEND="tk? ( dev-lang/tk dev-tcltk/tcllib )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i "s:\$(MAKE) install:&-nostripped:" "${S}"/Makefile || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dobin www/rem2html || die "dobin failed"

	dodoc README COPYRIGHT WINDOWS www/README.* || die "dodoc failed"

	if ! use tk ; then
		rm "${D}"/usr/bin/tkremind "${D}"/usr/share/man/man1/tkremind* \
			"${D}"/usr/bin/cm2rem*  "${D}"/usr/share/man/man1/cm2rem*
	fi

#	if use vim-syntax ; then
#		insinto /usr/share/vim/vimfiles/syntax
#		doins "${S}"/examples/remind.vim
#	fi
}

pkg_postinst() {
	elog "Some changes from 03.00.24:"
	elog "A reminders filename must be supplied to 'remind'. It is no longer"
	elog "optional. You can use 'rem' instead."
	elog "The environment variable that may contain your default reminders"
	elog "filename was renamed from DOT_REMINDERS to DOTREMINDERS."
}
