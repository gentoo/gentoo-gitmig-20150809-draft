# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-0.6.8.ebuild,v 1.10 2004/03/12 12:02:37 mr_bones_ Exp $

DESCRIPTION="A GTK+ frontend to cdlabelgen for easy and fast cd cover creation."
HOMEPAGE="http://gtkcdlabel.sourceforge.net"
SRC_URI="mirror://sourceforge/gtkcdlabel/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

RDEPEND=">=app-cdr/cdlabelgen-2.3.0
	>=media-libs/libcdaudio-0.99.6
	>=x11-libs/gtk+-1.2.0"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.6.1-r6"

src_compile() {
	# gtkcdlabel does not come with a configure, we must call
	# autogen.sh with the configure switches.
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure problem"
	# We must do this by hand.
	cp po/Makevars.template po/Makevars
	aclocal -I m4 || die "configure problem"
	# Second run _is_ needed.
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
}
