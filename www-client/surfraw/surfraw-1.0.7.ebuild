# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/surfraw/surfraw-1.0.7.ebuild,v 1.1 2005/03/18 14:51:04 seemant Exp $

DESCRIPTION="A fast unix command line interface to WWW"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/misc/proff/${P}.tar.gz"
HOMEPAGE="http://surfraw.sourceforge.net/"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""


src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--host=${CHOST} || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc README HACKING COPYING
}

pkg_postinst() {
	einfo
	einfo "You can get a list of installed elvi by just typing 'surfraw' "
	einfo
	einfo "You can try some searches, for example:"
	einfo "$ ask why is jeeves gay? "
	einfo "$ google -results=100 RMS, GNU, which is sinner, which is sin?"
	einfo "$ rhyme -method=perfect Julian"
	einfo
	einfo "The system configuration file is /etc/surfraw.conf"
	einfo
	einfo "Users can specify preferences in '~/.surfraw.conf'  e.g."
	einfo "SURFRAW_graphical_broswer=mozilla"
	einfo "SURFRAW_text_browser=w3m"
	einfo "SURFRAW_graphical=no"
	einfo
	einfo "surfraw works with any graphical and/or text WWW browser"
	einfo
}
