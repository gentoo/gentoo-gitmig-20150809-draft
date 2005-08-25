# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-6.0.1.ebuild,v 1.4 2005/08/25 05:50:30 ka0ttic Exp $

inherit eutils

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.wanadoo.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"
	epatch ${FILESDIR}/${P}-gcc4.diff
}

src_compile() {
	# ick. interactive makefile rule
	yes '' | make config

	if ! use nls ; then
		sed -i 's/\(ENABLE_NLS\ =\ \)y/\1n/g' build/CONFIG || \
			die "sed CONFIG failed"
	fi

	make PREFIX=/usr SA_LIB_DIR=/usr/lib/sa || die "make failed"
}

src_install() {
	keepdir /var/log/sa
	newdoc ${FILESDIR}/crontab crontab.example

	make \
		DESTDIR=${D} \
		PREFIX=/usr \
		MAN_DIR=/usr/share/man \
		DOC_DIR=/usr/share/doc/${PF} \
		SA_LIB_DIR=/usr/lib/sa \
		install || die "make install failed"
}
