# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-pl/man-pages-pl-20051024.ebuild,v 1.1 2006/04/09 13:17:43 spock Exp $

DESCRIPTION="A collection of Polish translations of Linux manual pages."
HOMEPAGE="http://ptm.linux.pl/"
SRC_URI="http://ptm.linux.pl/man-PL${PV:6:2}-${PV:4:2}-${PV:0:4}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"
DEPEND="sys-devel/autoconf"

S=${WORKDIR}/pl_PL

src_unpack() {
	unpack ${A}
	cd ${S}

	# missing manpages
	sed -i -e '/\tpasswd.1/ d' man1/Makefile.am

	# manpages provided by other packages
	mans="groups.1 apropos.1 man.1 su.1 newgrp.1 whatis.1 gpasswd.1 chsh.1 \
			chfn.1 login.1 expiry.1 porttime.5 lastlog.8 faillog.8 logoutd.8 \
			rpm.8 rpm2cpio.8"
	for page in ${mans} ; do
		sed -i -e "/\\t${page}/ d" man${page: -1}/Makefile.am
	done
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

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
