# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-pl/manpages-pl-20040401.ebuild,v 1.5 2004/11/19 22:56:18 sekretarz Exp $

DESCRIPTION="A collection of Polish translations of Linux manual pages."
HOMEPAGE="http://ptm.linux.pl/"
SRC_URI="http://ptm.linux.pl/man-PL${PV:6:2}-${PV:4:2}-${PV:0:4}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="sys-apps/man"
DEPEND="sys-devel/autoconf"

S="${WORKDIR}/pl_PL"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s#\tputmsg.2 ##" -r man2/Makefile.am
	sed -i -e "s#\tfprintf.3 ##" -e "s#\tMakefile.am ##" -r man3/Makefile.am
}

src_compile() {
	./autogen.sh \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
