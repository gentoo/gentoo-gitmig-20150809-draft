# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xcin/xcin-2.5.3_pre2.ebuild,v 1.4 2003/06/29 22:12:04 aliz Exp $

XCIN="${P/_/.}.tar.gz"
CHEWING="chewing-2002Jan07-snapshot.tar.gz"

DESCRIPTION="Chinese X Input Method"
HOMEPAGE="http://xcin.linux.org.tw/"
SRC_URI="ftp://xcin.linux.org.tw/pub/xcin/xcin/devel/${XCIN}
	http://chewing.good-man.org/snapshot/${CHEWING}"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86"
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
	cd ${S}
	patch -p0 < ${FILESDIR}/${PF}/gentoo-xcin.patch || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-xcin-rcdir=/etc \
		--with-xcin-dir=/usr/lib/X11/xcin25 \
		--with-db-lib=/usr/lib \
		--with-tabe-inc=/usr/include/tabe \
		--with-tabe-lib=/usr/lib  ||  die "./configure failed"
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		xcin_rcp=${D}/etc \
		xcin_binp=${D}/usr/bin \
		xcin_libp=${D}/usr/lib \
		xcin_modp=${D}/usr/lib/X11/xcin25 \
		mandir=${D}/usr/share/man \
		install || die
	dodir /etc
	insinto /etc
	newins ${FILESDIR}/gentoo-xcinrc xcinrc
	dodoc doc/*
	docinto En
	dodoc doc/En/*
	docinto En/internal
	dodoc doc/En/internal/*
	docinto history
	dodoc doc/history/*
	docinto internal
	dodoc doc/internal/*
	docinto modules
	dodoc doc/modules/*
}
