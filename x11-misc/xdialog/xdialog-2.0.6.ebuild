# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.0.6.ebuild,v 1.3 2003/09/05 23:29:06 msterret Exp $

IUSE="nls"

S=${WORKDIR}/${P/x/X}
DESCRIPTION="A drop-in replacement for cdialog.  Uses GTK for GUI dialog"
SRC_URI="http://ftp.debian.org/debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://xdialog.free.fr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_compile() {
	local myconf

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf}

	emake || die
}

src_install () {
	einstall || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README* TODO ABOUT-NLS

	cd doc
	dohtml -r .
}
