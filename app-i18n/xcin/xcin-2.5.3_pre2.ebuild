# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xcin/xcin-2.5.3_pre2.ebuild,v 1.12 2005/01/01 14:43:44 eradicator Exp $

inherit eutils

XCIN="${P/_/.}.tar.gz"
CHEWING="chewing-2002Jan07-snapshot.tar.gz"

DESCRIPTION="Chinese X Input Method"
HOMEPAGE="http://xcin.linux.org.tw/"
SRC_URI="ftp://xcin.linux.org.tw/pub/xcin/xcin/devel/${XCIN}
	http://chewing.good-man.org/snapshot/${CHEWING}"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )
	>=app-i18n/libtabe-0.2.5"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${XCIN}
	# patch for chewing support
	cd ${S}/src/Cinput
	unpack ${CHEWING}
	cd chewing
	./patch_chewing

	# gcc3.2 changed the way we deal with -I. So until the configure script
	# is updated we need this hack as a work around.
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-gentoo.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-db3.patch
}

src_compile() {
	econf \
		--with-xcin-rcdir=/etc \
		--with-xcin-dir=/usr/lib/X11/xcin25 \
		--with-db-lib=/usr/lib \
		--with-tabe-inc=/usr/include/tabe \
		--with-tabe-lib=/usr/lib  ||  die "./configure failed"
	emake || die
}

src_install() {
	make \
		prefix=${D}/usr \
		program_prefix=${D} \
		install || die
	dodir /etc
	insinto /etc
	newins ${FILESDIR}/gentoo-xcinrc xcinrc

	dodoc doc/*
	for docdir in doc/En doc/En/internal doc/history doc/internal doc/modules; do
		docinto ${docdir#doc/}
		dodoc ${docdir}/*
	done
}
