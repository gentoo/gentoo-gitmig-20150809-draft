# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-8b.ebuild,v 1.5 2003/03/11 21:11:45 seemant Exp $

IUSE="X ssl"

DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/otp_src_R8B-2.tar.gz"
S="${WORKDIR}/otp_src_R8B-2"

LICENSE="EPL"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND=">=dev-lang/perl-5.6.1
	X?	( >=x11-base/xfree-4.2.0-r12 )
	ssl?	( >=dev-libs/openssl-0.9.6d )"

src_compile() {
	econf --enable-threads || die "./configure failed"
	make || die
}

src_install() {
	ERL_LIBDIR="/usr/lib/erlang"

	make INSTALL_PREFIX=${D} install || die

	dosym ${ERL_LIBDIR}/bin/erl /usr/bin/erl
	dosym ${ERL_LIBDIR}/bin/erlc /usr/bin/erlc
	dosym ${ERL_LIBDIR}/erts-5.1.2/bin/epmd ${ERL_LIBDIR}/bin/

	## Remove ${D} from the /usr/lib/erlang/bin/erl and start script

	cd ${D}/${ERL_LIBDIR}/bin
	sed -e "s;${D};;" erl > erl.tmp
	mv ./erl.tmp ./erl
	sed -e "s;${D};;" start > start.tmp
	mv ./start.tmp ./start

	chmod 755 ./erl ./start


	## Clean up the no longer needed

	rm ${D}/${ERL_LIBDIR}/Install

	cd ${S}
	dodoc AUTHORS EPLICENCE README
}
