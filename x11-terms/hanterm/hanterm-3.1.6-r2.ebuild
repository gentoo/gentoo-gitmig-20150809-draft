# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/hanterm/hanterm-3.1.6-r2.ebuild,v 1.7 2003/09/09 03:02:36 usata Exp $ 

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Hanterm -- Korean terminal"
HOMEPAGE="http://www.hanterm.org/"
SRC_URI="http://hanterm.org/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="X11"

DEPEND="virtual/glibc
	>=x11-libs/Xaw3d-1.5
	virtual/x11
	media-fonts/baekmuk-fonts"

src_compile() {

	econf --with-Xaw3d --with-utempter || die
	emake || die
}

src_install() {

	einstall || die

	insinto /etc/X11/app-defaults
	newins Hanterm.ad Hanterm.orig
	newins ${FILESDIR}/Hanterm.gentoo Hanterm

	dodir /usr/X11R6/lib/X11
	dosym ../../../../etc/X11/app-defaults /usr/X11R6/lib/X11/app-defaults

	newman hanterm.man hanterm.1

	insinto /usr/share/doc/${PF}
	doins doc/devel/3final.gif
	dohtml doc/devel/hanterm.html

	dodoc README ChangeLog doc/{AUTHORS,THANKS,TODO}
	dodoc doc/devel/hanterm.sgml
	dodoc doc/historic/{ChangeLog*,DGUX.note,README*}
}
