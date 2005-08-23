# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-10.2.0.ebuild,v 1.7 2005/08/23 03:03:24 vapier Exp $

inherit eutils toolchain-funcs flag-o-matic elisp-common

#erlang uses a really weird versioning scheme which caused quite a few problems already
#Thus we do a slight modification converting all letters to digits to make it more sane (see e.g. #26420)
#the next line selects the right source.
MY_P=otp_src_R10B
MyDate="2004-10-05"
#apparently erlang people also started to stamp sources with a release date
DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/${MY_P}-0.tar.gz"

LICENSE="EPL"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="X ssl emacs"

DEPEND=">=dev-lang/perl-5.6.1
	X? ( virtual/x11 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	emacs? ( virtual/emacs )"

S=${WORKDIR}/${MY_P}_${MyDate}

SITEFILE=50erlang-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-10.2.6-export-TARGET.patch
}

src_compile() {
	[ "`gcc-fullversion`" == "3.3.2" ] && filter-mfpmath sse
	[ "`gcc-fullversion`" == "3.3.3" ] && filter-mfpmath sse
	addpredict /dev/pty # Bug #25366

	econf --enable-threads || die
	make || die

	if use emacs; then
		pushd ${D}/lib/tools/emacs
		elisp-compile *.el
		popd
	fi
}

src_install() {
	ERL_LIBDIR="/usr/$(get_libdir)/erlang"

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
	cd ${ERL_LIBDIR}/erts-*
	grep -rle ${D} ${D}/${ERL_LIBDIR}/erts-* | xargs sed -i -e "s:${D}::g"

	## Clean up the no longer needed files
	rm ${D}/${ERL_LIBDIR}/Install

	if use emacs; then
		pushd ${S}
		elisp-install erlang lib/tools/emacs/*.el
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
		popd
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
