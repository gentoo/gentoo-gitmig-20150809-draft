# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-8b.ebuild,v 1.9 2004/03/30 20:49:43 spyderous Exp $

MY_P=otp_src_R8B-2
DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/${MY_P}.tar.gz"

LICENSE="EPL"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="X ssl"

DEPEND=">=dev-lang/perl-5.6.1
	X? ( virtual/x11 )
	ssl? ( >=dev-libs/openssl-0.9.6d )"

S=${WORKDIR}/${MY_P}

addpredict /dev/pty # Bug #25366

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
	dosym ${ERL_LIBDIR}/erts-5.1.2/bin/epmd ${ERL_LIBDIR}/bin/

	## Remove ${D} from the /usr/lib/erlang/bin/erl and start script
	dosed ${ERL_LIBDIR}/bin/erl
	dosed ${ERL_LIBDIR}/bin/start

	## Clean up the no longer needed
	rm ${D}/${ERL_LIBDIR}/Install
}
