# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfm/xfm-1.4.3.ebuild,v 1.1 2003/11/18 19:49:04 port001 Exp $

DESCRIPTION="A classic X11 file manager"
HOMEPAGE="http://www.musikwissenschaft.uni-mainz.de/~ag/xfm/"
SRC_URI="http://www.musikwissenschaft.uni-mainz.de/~ag/xfm/${P}.tar.gz"

KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

IUSE=""

RDEPEND="virtual/x11
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	sed -i \
		-e 's:$(DESTDIR)$(BINDIR):$(BINDIR):g' \
		-e 's:$(XFMLIBDIR)/:$(DESTDIR)/$(XFMLIBDIR)/:g' Imakefile || \
			die "sed Imakefile failed"
	xmkmf -a || die
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install install.man || die "make install failed"
	dodoc ChangeLog INSTALL REAEDME README-1.2 README-1.4 TODO
}

pkg_postinst() {
	einfo
	einfo "The user you intend to use ${PN} as (not root!!),"
	einfo "just type ${PN}.install"
	einfo
}
