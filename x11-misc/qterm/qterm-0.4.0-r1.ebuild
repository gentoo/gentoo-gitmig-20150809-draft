# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.4.0-r1.ebuild,v 1.3 2008/01/19 00:38:33 matsuu Exp $

inherit eutils qt3

DESCRIPTION="QTerm is a BBS client in Linux."
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="arts esd ssl"

DEPEND="dev-lang/python
	$(qt3_min_version 3.1)
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^Exec/s/qterm/QTerm/' qterm/qterm.desktop.in || die
}

src_compile() {
	# fix the broken language files
	lrelease qterm/po/qterm_ch*.ts

	# yeah, it's --disable-ssh to disable ssl
	local myconf="`use_enable esd` `use_enable ssl ssh` --program-transform-name=QTerm"

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
	emake install DESTDIR="${D}" || die "install faled"
	dodoc AUTHORS BUGS ChangeLog README* RELEASE_NOTES
	# #176533
	mv "${D}"/usr/bin/qterm "${D}"/usr/bin/QTerm || die
}

pkg_postinst() {
	elog
	elog "Since 0.4.0-r1, /usr/bin/qterm has been renamed to /usr/bin/QTerm."
	elog "Please see bug #176533 for more information."
	elog
}
