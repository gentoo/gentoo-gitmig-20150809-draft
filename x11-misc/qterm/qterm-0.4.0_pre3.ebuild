# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.4.0_pre3.ebuild,v 1.2 2006/01/07 18:43:30 carlo Exp $

inherit kde-functions eutils

DESCRIPTION="QTerm is a BBS client in Linux."
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts esd ssl"
DEPEND=">=media-sound/esound-0.2.22
	dev-lang/python
	ssl? ( dev-libs/openssl )"
need-qt 3

S=${WORKDIR}/${P/_/}

src_compile() {

	cd ${S}/qterm && epatch ${FILESDIR}/qstring.patch
	cd ${S}

	# yeah, it's --disable-ssh to disable ssl
	local myconf="`use_enable esd` `use_enable ssl ssh`"

	# Although "configure --help" claims use "--with-arts-dir" to set aRts dir, it actually
	# check the value of "--with-artsdir" option. To gracefully fix this bug, I have to run
	# s/(artsdir/(arts-dir/ to ${S}/admin/acinclude.m4.in, then make -f Makefile.dist to 
	# regenerate the configure script. For simplicity I choose to just use the buggy script
	# and give it the "wrong" option.
	use arts && myconf="${myconf} --enable-arts --with-artsdir=`kde-config --prefix`" \
			|| myconf="${myconf} --disable-arts"

	econf ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "install faled"
	dodoc AUTHORS BUGS COPYING ChangeLog README* RELEASE_NOTES
}
