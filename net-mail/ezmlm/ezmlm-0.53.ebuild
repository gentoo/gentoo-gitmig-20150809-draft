# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ezmlm/ezmlm-0.53.ebuild,v 1.6 2002/07/17 04:20:40 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Simple yet powerful mailing list manager for qmail."
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"
HOMEPAGE="http://cr.yp.to/software/ezmlm.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND=" sys-apps/groff"

RDEPEND="net-mail/qmail"


src_compile() {
	cd ${S}
	mkdir tmp
	echo "/usr/bin" > conf-bin
	echo "/usr/share/man" > conf-man
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
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
