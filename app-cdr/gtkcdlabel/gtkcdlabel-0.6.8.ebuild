# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gtkcdlabel/gtkcdlabel-0.6.8.ebuild,v 1.1 2002/08/03 16:59:52 blizzy Exp $

DESCRIPTION="A GTK+ frontend to cdlabelgen for easy and fast cd cover creation."
HOMEPAGE="http://gtkcdlabel.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/gtkcdlabel/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=app-cdr/cdlabelgen-2.3.0
	>=media-libs/libcdaudio-0.99.6
	>=x11-libs/gtk+-1.2.0"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.6.1-r6"

S="${WORKDIR}/${P}"

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

src_install () {
	make DESTDIR=${D} install || die "install problem"
}
