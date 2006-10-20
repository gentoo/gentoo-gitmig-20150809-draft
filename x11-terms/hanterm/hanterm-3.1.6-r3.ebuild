# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/hanterm/hanterm-3.1.6-r3.ebuild,v 1.1 2006/10/20 23:49:56 flameeyes Exp $

IUSE="utempter"

DESCRIPTION="Hanterm -- Korean terminal"
HOMEPAGE="http://www.hanterm.org/"
SRC_URI="http://download.kldp.net/hanterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="~ppc ~ppc-macos ~x86"
LICENSE="X11"

DEPEND="x11-libs/libXmu
	x11-libs/libICE
	x11-libs/libXaw
	utempter? ( sys-libs/libutempter )
	>=x11-libs/Xaw3d-1.5"
RDEPEND="${DEPEND}
	media-fonts/baekmuk-fonts"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:extern char \*malloc();::" \
		-e "s:extern char \*realloc();::" \
		button.c charproc.c
	if use ppc-macos ; then
		sed -i -e "s:extern int sys_nerr;::" misc.c
	fi
}

src_compile() {
	econf \
		--with-Xaw3d \
		$(use_with utempter) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die

	insinto /usr/share/X11/app-defaults
	newins Hanterm.ad Hanterm.orig
	newins "${FILESDIR}/Hanterm.gentoo" Hanterm

	newman hanterm.man hanterm.1

	insinto /usr/share/doc/${PF}
	doins doc/devel/3final.gif
	dohtml doc/devel/hanterm.html

	dodoc README ChangeLog doc/{AUTHORS,THANKS,TODO}
	dodoc doc/devel/hanterm.sgml
	dodoc doc/historic/{ChangeLog*,DGUX.note,README*}
}
