# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-9c.ebuild,v 1.1 2003/05/10 18:59:14 george Exp $

IUSE="X ssl"

DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/otp_src_R9B-1.tar.gz"
S="${WORKDIR}/otp_src_R9B-1"

LICENSE="EPL"
SLOT="0"
KEYWORDS="~x86"

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
	dosym ${ERL_LIBDIR}/bin/ecc /usr/bin/ecc
	dosym ${ERL_LIBDIR}/bin/elink /usr/bin/elink
	dosym ${ERL_LIBDIR}/bin/ear /usr/bin/ear
	dosym ${ERL_LIBDIR}/bin/escript /usr/bin/escript

	## Remove ${D} from the following files

	cd ${D}/${ERL_LIBDIR}/bin
	sed -e "s;${D};;" erl > erl.tmp
	mv ./erl.tmp ./erl
	sed -e "s;${D};;" start > start.tmp
	mv ./start.tmp ./start
	sed -e "s;${D};;" ecc > ecc.tmp
	mv ./ecc.tmp ./ecc
	sed -e "s;${D};;" ear > ear.tmp
	mv ./ear.tmp ./ear
	sed -e "s;${D};;" elink > elink.tmp
	mv ./elink.tmp ./elink
	sed -e "s;${D};;" escript > escript.tmp
	mv ./escript.tmp ./escript
	sed -e "s;${D};;" esh > esh.tmp
	mv ./esh.tmp ./esh

	chmod 755 ./erl ./start ./ecc ./ear ./elink ./escript ./esh


	## Clean up the no longer needed files

	rm ${D}/${ERL_LIBDIR}/Install

	cd ${S}
	dodoc AUTHORS EPLICENCE README
}
