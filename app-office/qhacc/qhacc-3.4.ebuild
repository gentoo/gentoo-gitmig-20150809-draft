# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qhacc/qhacc-3.4.ebuild,v 1.4 2006/02/25 15:40:59 carlo Exp $

inherit libtool kde-functions eutils

DESCRIPTION="Personal Finance for Qt"
HOMEPAGE="http://qhacc.sourceforge.net/"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~hppa ~ppc ~sparc ~x86"
IUSE="crypt doc mysql ofx postgres sqlite"

DEPEND="ofx? ( ~dev-libs/libofx-0.7.0 )
	crypt? ( >=app-crypt/gpgme-0.9.0-r1 )
	mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite )"
need-qt 3

src_unpack() {
	unpack "${A}"
	cd "${S}"
	elibtoolize
}

src_compile() {
	econf --libdir=/usr/$(get_libdir)/qhacc \
		--bindir=/usr/bin \
		--includedir=/usr/include \
		--datadir=/usr/share/qhacc \
		--with-qt-includes=/usr/qt/3/include \
		--with-qt-libs=/usr/qt/3/lib \
		--with-qt-moc=/usr/qt/3/bin \
		$(use_enable mysql) \
		$(use_enable postgres psql) \
		$(use_enable sqlite) \
		$(use_enable ofx) \
		$(use_enable crypt gpg) \
		$(use_with ofx ofx-includes /usr/include/libofx) \
		|| die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	rm ${S}/contrib/easysetup/Makefile*
	insinto /usr/share/qhacc/easysetup
	doins ${S}/contrib/easysetup/*
	dodoc AUTHORS ChangeLog FILE_FORMAT INSTALL NEWS README THANKS TODO UPGRADE
	dosym /usr/share/qhacc/doc/html /usr/share/doc/${PF}/html
}

pkg_postinst() {
	echo ""
	einfo "A sample configuration is provided in /usr/share/qhacc/easysetup."
	einfo "copy files: mkdir ~/.qhacc ; cp /usr/share/qhacc/easysetup/* ~/.qhacc"
	einfo "run program: qhacc -f ~/.qhacc/"
	einfo "set alias: echo -e \\\n \"alias qhacc=\\\"qhacc -f ~/.qhacc\\\"\" >> ~/.bashrc"
	echo ""
	ewarn "To update from a previous version, please read /usr/share/doc/${PF}/UPGRADE.gz"
	echo ""
}
