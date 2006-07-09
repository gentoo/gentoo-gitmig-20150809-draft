# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.9i.ebuild,v 1.1 2006/07/09 16:33:30 mkennedy Exp $

inherit eutils

DESCRIPTION="ECL is an embeddable Common Lisp implementation."
SRC_URI="mirror://sourceforge/ecls/ecl-${PV}.tgz"
HOMEPAGE="http://ecls.sourceforge.net/"
SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

DEPEND="=dev-libs/gmp-4*
	app-text/texi2html"

# ECL fails to build with a system-installed Boehm GC (which apparently is a
# rare configuration since most distributions neglect to install the useful
# private headers). Until this is properly isolated, we use the Boehm GC
# included with ECL.

#	dev-libs/boehm-gc

IUSE="X c++"

PROVIDE="virtual/commonlisp"

S=${WORKDIR}/ecl-${PV:0:4}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-headers-gentoo.patch || die
	# waiting on upstream to fix this http://sourceforge.net/tracker/?func=detail&aid=1519256&group_id=30035&atid=398053
#	epatch ${FILESDIR}/${PV}-sockets-c++-gentoo.patch || die
}

src_compile() {
	local myconf="--with-system-gmp
		--enable-boehm=included
		--with-tcp
		--with-ffi
		--with-clos-streams
		--with-cmuformat
		--with-asdf
		`use_with c++ cxx`
		`use_with X x`
		`use_with X clx`"
	einfo "Configuring with: $myconf"
	econf ${myconf} || die
	make || die
}

src_install () {
	make bindir=${D}/usr/bin \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/lib/ecl \
		includedir=${D}/usr/include \
		docdir=${D}/usr/share/doc/${PF} install || true
	dohtml doc/*.html
	dodoc ANNOUNCEMENT Copyright LGPL

	insinto /usr/share/doc/${PF}/
	doins ${FILESDIR}/README.Gentoo
}
