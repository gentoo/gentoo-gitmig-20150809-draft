# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-1.5.2.ebuild,v 1.8 2004/11/17 16:36:21 vapier Exp $

DESCRIPTION="File integrity verification system"
HOMEPAGE="http://osiris.shmoo.com/"
SRC_URI="http://osiris.shmoo.com/data/${P}.tar.gz"

LICENSE="OSIRIS"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql"

DEPEND="mysql? ( >=dev-db/mysql-3.23.54a )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-O3 -fomit-frame-pointer:${CFLAGS}:" \
		src/crypto/*/Makefile || die "sed"
}

src_compile() {
	# Osiris provides the necessary gdbm source so that gdbm does not
	# need to be installed to use Osiris. If mysql is set as a USE
	# variable, Osiris will use mysql instead of gdbm.
	einfo "Osiris uses gdbm by default, and will use MySQL if \"mysql\""
	einfo "is set as a USE variable; it cannot be configured to use both."

	local myconf
	use mysql \
		&& myconf="${myconf} --enable-module=mysql" \
		&& sed -i -e "s:mysql.h:mysql/mysql.h:" ${S}/src/modules/module_mysql.c
	econf ${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die
}
