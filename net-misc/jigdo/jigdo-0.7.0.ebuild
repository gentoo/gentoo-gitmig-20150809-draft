# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jigdo/jigdo-0.7.0.ebuild,v 1.7 2004/11/30 22:25:16 swegener Exp $

inherit eutils

DESCRIPTION="Jigsaw Download, or short jigdo, is a tool designed to ease the distribution of very large files over the internet, for example CD or DVD images."
HOMEPAGE="http://atterer.net/jigdo/"
SRC_URI="http://atterer.net/jigdo/jigdo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

IUSE="gtk nls berkdb"

DEPEND="gtk? ( >=x11-libs/gtk+-2.0.6 )
	nls? ( sys-devel/gettext )
	berkdb? ( =sys-libs/db-3* )
	>=net-libs/libwww-5.3.2"

src_compile() {
	local myconf

	# Fix for bug #32029.
	if use berkdb; then
		cd ${S}
		epatch ${FILESDIR}/jigdo-gentoo-db3.patch
	fi

	use nls || myconf="${myconf} --disable-nls"
	use gtk || myconf="${myconf} --without-libdb --without-gui"
	use berkdb || myconf="${myconf} --without-libdb"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man ${myconf} \
		--datadir=/usr/share || die "./configure failed"

	# Patch the Makefile so that when jidgo is installed, jigdo-lite has
	# the correct path to the debian mirrors file.
	epatch ${FILESDIR}/makefile.patch

	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING README THANKS VERSION changelog
	dodoc doc/*.txt
	dohtml doc/*.html
}
