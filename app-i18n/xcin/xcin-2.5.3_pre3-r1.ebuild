# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xcin/xcin-2.5.3_pre3-r1.ebuild,v 1.2 2005/03/22 07:21:10 usata Exp $

inherit rpm eutils

XCINRPMSRC="${P/_/.}-20.10.firefly.src.rpm"

DESCRIPTION="Chinese X Input Method"
HOMEPAGE="http://xcin.linux.org.tw/
	http://firefly.idv.tw/test/Forum.php?Board=1"
SRC_URI="http://firefly.idv.tw/setfont-xft/Fedora/Core_1/SRPMS/${XCINRPMSRC}"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86"
IUSE="nls unicode"

DEPEND="dev-libs/libchewing
	nls? ( sys-devel/gettext )
	>=app-i18n/libtabe-0.2.5
	unicode? ( media-fonts/hkscs-ming )"

S=${WORKDIR}/${PN}

src_unpack() {
	rpm_src_unpack

	cd ${S}
	epatch ${FILESDIR}/xcin-chewing.diff

	# gcc3.2 changed the way we deal with -I. So until the configure script
	# is updated we need this hack as a work around.
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P/pre3/pre2}-gentoo.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-db3.patch

	# begin firefly unicode patches
	cd ${S}
	for I in ${WORKDIR}/*.patch;do
		epatch ${I}
	done

	# paar's fix
	mv ${S}/xcin/cin/big5/* ${S}/cin/big5/
}

src_compile() {
	econf \
		--with-xcin-rcdir=/etc \
		--with-xcin-dir=/usr/lib/xcin25 \
		--with-db-lib=/usr/lib \
		--with-tabe-inc=/usr/include/tabe \
		--with-tabe-lib=/usr/lib  ||  die "./configure failed"
	emake -j1 || die
}

src_install() {
	make \
		prefix=${D}/usr \
		program_prefix=${D} \
		install || die
	dodir /etc

	insinto /etc
	doins ${FILESDIR}/xcinrc
	dodoc doc/*

	for docdir in doc/En doc/En/internal doc/history doc/internal doc/modules; do
		docinto ${docdir#doc/}
		dodoc ${docdir}/*
	done
}
