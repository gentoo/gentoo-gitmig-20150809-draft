# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qhacc/qhacc-3.2.1.ebuild,v 1.1 2004/09/13 19:31:36 carlo Exp $

inherit libtool kde-functions eutils

DESCRIPTION="Personal Finance for QT"
HOMEPAGE="http://qhacc.sourceforge.net/"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="doc mysql postgres sqlite xml"

DEPEND="mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite )"
RDEPEND="mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite )"
need-qt 3

src_compile() {
	elibtoolize

	local myconf="--libdir=/usr/lib/qhacc --bindir=/usr/bin --includedir=/usr/include --datadir=/usr/share/qhacc
			$(use_enable mysql)
			$(use_enable postgres psql)
			$(use_enable mysql)"
	# libofx would need to be patched 
	# $(use_enable ofx) $(use_enable ofx ofx-includes /usr/include/libofx)

	econf ${myconf} || die "./configure failed"
	emake -j 1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	# can't do this and I'm too lazy to patch all the Makefiles
	# mv ${D}/usr/plugins ${D}/usr/lib/qhacc
	dodir /usr/share/doc/${PF}
	use doc && mv ${D}/${D}/usr/share/doc/* ${D}/usr/share/doc/${PF}
	rm -rf ${D}/${D}/usr/share/doc
	dodir /usr/share/qhacc
	mv ${D}/${D}/usr/share/* ${D}/usr/share/qhacc
	rm ${S}/contrib/easysetup/Makefile*
	insinto /usr/share/qhacc/easysetup
	doins ${S}/contrib/easysetup/*
	rm -rf ${D}/var
	dodoc AUTHORS ChangeLog COPYING FILE_FORMAT INSTALL NEWS README THANKS TODO UPGRADE
}

pkg_postinst() {
	echo
	einfo "A sample configuration is provided in /usr/share/qhacc/easysetup."
	einfo "copy files: \`mkdir ~/.qhacc ; cp /usr/share/qhacc/easysetup/* ~/.qhacc\`"
	einfo "run program: \`qhacc -f ~/.qhacc/\`"
	einfo "set alias: \`echo -e \\\n \"alias qhacc=\\\"qhacc -f ~/.qhacc\\\"\" >> ~/.bashrc\`"
	echo
}
