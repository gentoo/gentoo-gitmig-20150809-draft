# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}

DEPEND="virtual/glibc
	sys-apps/groff"

RDEPEND="net-mail/qmail"

DESCRIPTION="Simple yet powerful mailing list manager for qmail."
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"

HOMEPAGE="http://cr.yp.to/software/ezmlm.html"

src_compile() {
	cd ${S}
	mkdir tmp
	echo "./tmp" > conf-bin
	echo "./tmp" > conf-man
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
	make setup check || die
}

src_install () {
	exeinto /usr/bin
	doexe ezmlm-list ezmlm-make ezmlm-manage \
	ezmlm-reject ezmlm-return ezmlm-send \
	ezmlm-sub ezmlm-unsub ezmlm-warn ezmlm-weed

	doman ezmlm-list.1 ezmlm-make.1 ezmlm-manage.1 \
	ezmlm-reject.1 ezmlm-return.1 ezmlm-send.1 \
	ezmlm-sub.1 ezmlm-unsub.1 ezmlm-warn.1 ezmlm-weed.1 \
	ezmlm.5
}
