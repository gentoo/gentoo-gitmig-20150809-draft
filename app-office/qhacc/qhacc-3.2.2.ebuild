# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qhacc/qhacc-3.2.2.ebuild,v 1.1 2004/10/29 19:00:00 carlo Exp $

inherit libtool kde-functions eutils

DESCRIPTION="Personal Finance for Qt"
HOMEPAGE="http://qhacc.sourceforge.net/"
SRC_URI="mirror://sourceforge/qhacc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="doc mysql ofx postgres sqlite"

DEPEND="ofx? ( ~dev-libs/libofx-0.7.0 )
	mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite )"
RDEPEND="ofx? ( ~dev-libs/libofx-0.7.0 )
	mysql? ( dev-db/mysql++ )
	postgres? ( dev-db/postgresql )
	sqlite? ( dev-db/sqlite )"
need-qt 3

src_unpack() {
	unpack ${A}
	cd ${S}
	elibtoolize
	epatch ${FILESDIR}/${P}-sandbox.patch
}

src_compile() {
	local myconf="--libdir=/usr/lib/qhacc --bindir=/usr/bin --includedir=/usr/include --datadir=/usr/share/qhacc
			$(use_enable mysql)
			$(use_enable postgres psql)
			$(use_enable sqlite)
			$(use_enable ofx) $(use_with ofx ofx-includes /usr/include/libofx)"

	econf ${myconf} || die "./configure failed"
	emake -j 1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodir /usr/share/doc/${PF}
	use doc && mv ${D}/usr/share/qhacc/doc/* ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/share/qhacc/doc
	rm ${S}/contrib/easysetup/Makefile*
	insinto /usr/share/qhacc/easysetup
	doins ${S}/contrib/easysetup/*
	rm -rf ${D}/var
	dodoc AUTHORS ChangeLog COPYING FILE_FORMAT INSTALL NEWS README THANKS TODO UPGRADE
}

pkg_postinst() {
	echo ""
	einfo "A sample configuration is provided in /usr/share/qhacc/easysetup."
	einfo "copy files: \`mkdir ~/.qhacc ; cp /usr/share/qhacc/easysetup/* ~/.qhacc\`"
	einfo "run program: \`qhacc -f ~/.qhacc/\`"
	einfo "set alias: \`echo -e \\\n \"alias qhacc=\\\"qhacc -f ~/.qhacc\\\"\" >> ~/.bashrc\`"
	echo ""
}
