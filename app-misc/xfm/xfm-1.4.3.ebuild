# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/xfm/xfm-1.4.3.ebuild,v 1.1 2003/07/29 17:37:27 bcowan Exp $

DESCRIPTION="A classic X11 file managers"
HOMEPAGE="http://www.musikwissenschaft.uni-mainz.de/~ag/xfm/"
SRC_URI="http://www.musikwissenschaft.uni-mainz.de/~ag/xfm/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

IUSE=""

RDEPEND="virtual/x11
	x11-libs/xaw"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${P}

src_compile() {
	cp Imakefile ${T}/Imakefile
	sed -e 's:$(DESTDIR)$(BINDIR):$(BINDIR):g' ${T}/Imakefile | \
		sed -e 's:$(XFMLIBDIR)/:$(DESTDIR)/$(XFMLIBDIR)/:g' > Imakefile || die
	xmkmf -a || die
	make CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install install.man
	dodoc ChangeLog INSTALL REAEDME README-1.2 README-1.4 TODO
}

pkg_postinst() {
	einfo ""
	einfo "The user you intend to use ${PN} as (not root!!),"
	einfo "just type ${PN}.install"
	einfo ""
}
