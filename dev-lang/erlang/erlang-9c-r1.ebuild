# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-9c-r1.ebuild,v 1.6 2004/03/30 20:49:43 spyderous Exp $

inherit eutils

MY_P=otp_src_R9B-1
DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/${MY_P}.tar.gz"

LICENSE="EPL"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="X ssl"

DEPEND=">=dev-lang/perl-5.6.1
	X? ( virtual/x11 )
	ssl? ( >=dev-libs/openssl-0.9.6d )"

S=${WORKDIR}/${MY_P}

addpredict /dev/pty # Bug #25366

src_unpack(){
	unpack ${A}
	cd ${S}
	#combines nsswitch.conf parsing and a fix for strange install behaviour on some systems
	epatch ${FILESDIR}/${P}.patch.gz
}

src_compile() {
	econf --enable-threads || die "./configure failed"
	make || die
}

src_install() {
	ERL_LIBDIR="/usr/lib/erlang"

	make INSTALL_PREFIX=${D} install || die
	dodoc AUTHORS EPLICENCE README

	dosym ${ERL_LIBDIR}/bin/erl /usr/bin/erl
	dosym ${ERL_LIBDIR}/bin/erlc /usr/bin/erlc
	dosym ${ERL_LIBDIR}/bin/ecc /usr/bin/ecc
	dosym ${ERL_LIBDIR}/bin/elink /usr/bin/elink
	dosym ${ERL_LIBDIR}/bin/ear /usr/bin/ear
	dosym ${ERL_LIBDIR}/bin/escript /usr/bin/escript

	## Remove ${D} from the following files
	dosed ${ERL_LIBDIR}/bin/erl
	dosed ${ERL_LIBDIR}/bin/start
	dosed ${ERL_LIBDIR}/bin/ecc
	dosed ${ERL_LIBDIR}/bin/ear
	dosed ${ERL_LIBDIR}/bin/elink
	dosed ${ERL_LIBDIR}/bin/escript
	dosed ${ERL_LIBDIR}/bin/esh
	dosed ${ERL_LIBDIR}/erts-*/bin/erl
	dosed ${ERL_LIBDIR}/erts-*/bin/start

	## Clean up the no longer needed files
	rm ${D}/${ERL_LIBDIR}/Install
}
