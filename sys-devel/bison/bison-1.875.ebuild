# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bison/bison-1.875.ebuild,v 1.9 2004/02/01 10:54:01 kumba Exp $

IUSE="nls static build" # icc"

S="${WORKDIR}/${P}"
DESCRIPTION="A yacc-compatible parser generator"
SRC_URI="mirror://gnu/bison/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/bison/bison.html"

LICENSE="GPL-2"
SLOT="0"
# do not compile xfree
KEYWORDS="amd64 ~x86 ~ppc ~sparc alpha mips hppa ~arm ia64 ppc64"

DEPEND="sys-devel/m4
	nls? ( sys-devel/gettext )"
#	icc? ( dev-lang/icc )"


src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-1.32-extfix.patch
	epatch ${FILESDIR}/${PN}-1.875-gccerror.patch
}

src_compile() {

	local myconf=

	use nls || myconf="--disable-nls"
#	use icc && CC="iccbin" CXX="iccbin" LD="iccbin"

	econf ${myconf} || die

	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS="-static" || die
	fi
}

src_install() {

	make DESTDIR=${D} \
		datadir=/usr/share \
		mandir=/usr/share/man \
		infodir=/usr/share/info \
		install || die

	# This one is installed by dev-util/yacc
	mv ${D}/usr/bin/yacc ${D}/usr/bin/yacc.bison

	# We do not need this.
	rm -f ${D}/usr/lib/liby.a

	dodoc COPYING AUTHORS NEWS ChangeLog README REFERENCES OChangeLog
	docinto txt
	dodoc doc/FAQ
}

