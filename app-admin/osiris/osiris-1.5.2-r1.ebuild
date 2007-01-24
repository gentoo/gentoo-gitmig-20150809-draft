# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-1.5.2-r1.ebuild,v 1.3 2007/01/24 14:46:42 genone Exp $

DESCRIPTION="File integrity verification system"
HOMEPAGE="http://osiris.shmoo.com/"
SRC_URI="http://osiris.shmoo.com/data/${P}.tar.gz"

LICENSE="OSIRIS"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mysql doc"

DEPEND="mysql? ( virtual/mysql )"

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
	elog "Osiris uses gdbm by default, and will use MySQL if \"mysql\""
	elog "is set as a USE variable; it cannot be configured to use both."

	local myconf
	use mysql \
		&& myconf="${myconf} --enable-module=mysql" \
		&& sed -i -e "s:mysql.h:mysql/mysql.h:" ${S}/src/modules/module_mysql.c
	econf ${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	if use doc
	then
		insinto /usr/share/doc/${PF}
		dohtml docs/manual.html
		dodoc docs/manual.txt
		doins -r configs
	fi
}
