# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.875.ebuild,v 1.11 2004/02/06 15:58:08 agriffis Exp $

inherit gcc

IUSE="nls static"

S="${WORKDIR}/${P}"
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="mirror://gnu/bison/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc ~sparc alpha mips hppa ~arm ia64 ppc64"

DEPEND="sys-devel/m4
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A} && cd ${S} || die
	epatch ${FILESDIR}/${PN}-1.32-extfix.patch
	epatch ${FILESDIR}/${PN}-1.875-gccerror.patch
}

src_compile() {
	# Bug 39842 says that bison segfaults when built on amd64 with
	# optimizations.  This will probably be fixed in a future gcc
	# version, but for the moment just disable optimizations for that
	# arch (04 Feb 2004 agriffis)
	[[ $ARCH == amd64 ]] && append-flags -O0

	# Bug 29017 says that bison has compile-time issues with
	# -march=k6* prior to 3.4CVS.  Use -march=i586 instead 
	# (04 Feb 2004 agriffis)
	if [[ $(gcc-major-version) == 3 && $(gcc-minor-version) < 4 ]]; then
		CFLAGS=" ${CFLAGS} "
		CFLAGS=${CFLAGS// -march=k6-? / -march=i586 }
		CFLAGS=${CFLAGS// -march=k6 / -march=i586 }
	fi

	econf $(use_enable nls) || die

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
	mv ${D}/usr/bin/yacc ${D}/usr/bin/yacc.bison || die

	# We do not need this.
	rm -f ${D}/usr/lib/liby.a

	dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog
	docinto txt
	dodoc doc/FAQ
}

