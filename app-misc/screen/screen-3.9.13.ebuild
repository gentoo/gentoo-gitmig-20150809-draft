# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-3.9.13.ebuild,v 1.3 2002/12/15 10:44:11 bjb Exp $

HOMEPAGE="http://www.gnu.org/software/screen/"
DESCRIPTION="Full-screen window manager that multiplexes physical terminals between several processes"
SRC_URI="ftp://ftp.uni-erlangen.de/pub/utilities/screen/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	unpack ${A}
	cd ${S}
}
src_compile() {
	addpredict "`tty`"
	addpredict "${SSH_TTY}"

	econf \
		--with-sys-screenrc=/etc/screen/screenrc \
		--libexecdir=/usr/lib/misc || die
	emake || die
}

src_install () {
	dobin screen
	insinto /usr/share/terminfo
	doins terminfo/screencap
	insinto /etc/screen
	doins etc/screenrc
	dodoc README ChangeLog INSTALL COPYING TODO NEWS* \
	doc/{FAQ,README.DOTSCREEN,fdpat.ps,window_to_display.ps}
	doman doc/screen.1
	doinfo doc/screen.info*
}
