# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.875.ebuild,v 1.23 2004/07/19 15:53:22 solar Exp $

inherit gcc flag-o-matic eutils gnuconfig

DESCRIPTION="A yacc-compatible parser generator"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"
SRC_URI="mirror://gnu/bison/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls static uclibc"

DEPEND="sys-devel/m4
	nls? ( sys-devel/gettext )"

use uclibc && PROVIDE="dev-util/yacc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.32-extfix.patch
	epatch ${FILESDIR}/${PN}-1.875-gccerror.patch
	gnuconfig_update
}

src_compile() {
	# Bug 39842 says that bison segfaults when built on amd64 with
	# optimizations.  This will probably be fixed in a future gcc
	# version, but for the moment just disable optimizations for that
	# arch (04 Feb 2004 agriffis)
	[ "$ARCH" == "amd64" ] && append-flags -O0

	# Bug 29017 says that bison has compile-time issues with
	# -march=k6* prior to 3.4CVS.  Use -march=i586 instead
	# (04 Feb 2004 agriffis)
	#
	if (( $(gcc-major-version) == 3 && $(gcc-minor-version) < 4 )) ; then
		replace-cpu-flags i586 k6 k6-1 k6-2
	fi

	econf `use_enable nls` || die

	if use static; then
		emake LDFLAGS="-static" || die
	else
		emake || die
	fi
}

src_install() {
	make DESTDIR=${D} \
		datadir=/usr/share \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		install || die

	# This one is installed by dev-util/yacc
	if ! use uclibc; then
		mv ${D}/usr/bin/yacc ${D}/usr/bin/yacc.bison || die
	fi

	# We do not need this.
	rm -f ${D}/usr/lib/liby.a

	dodoc AUTHORS NEWS ChangeLog README REFERENCES OChangeLog
	docinto txt
	dodoc doc/FAQ
}
