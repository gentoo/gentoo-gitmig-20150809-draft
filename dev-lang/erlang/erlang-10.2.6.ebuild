# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/erlang/erlang-10.2.6.ebuild,v 1.4 2005/08/24 00:43:36 vapier Exp $

inherit eutils multilib flag-o-matic elisp-common

#erlang uses a really weird versioning scheme which caused quite a few problems already
#Thus we do a slight modification converting all letters to digits to make it more sane (see e.g. #26420)
#the next line selects the right source.
MY_PV=R10B-6
MY_P=otp_src_${MY_PV}
DESCRIPTION="Erlang programming language, runtime environment, and large collection of libraries"
HOMEPAGE="http://www.erlang.org/"
SRC_URI="http://www.erlang.org/download/${MY_P}.tar.gz
	doc? ( http://erlang.org/download/otp_doc_man_${MY_PV}.tar.gz
		http://erlang.org/download/otp_doc_html_${MY_PV}.tar.gz )"

LICENSE="EPL"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc emacs java odbc ssl X"

RDEPEND=">=dev-lang/perl-5.6.1
	X? ( virtual/x11 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	emacs? ( virtual/emacs )
	java? ( >=virtual/jdk-1.2 )
	odbc? ( dev-db/unixODBC )"
DEPEND="${RDEPEND}
	dev-lang/tk"

S=${WORKDIR}/${MY_P}

SITEFILE=50erlang-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-export-TARGET.patch
	epatch "${FILESDIR}"/${PV}-manpage-emacs-gentoo.patch
	use odbc || sed -i 's: odbc : :' lib/Makefile
}

src_compile() {
	use java || export JAVAC=false
	econf \
		--enable-threads \
		$(use_with ssl) \
		|| die
	make || die

	if use emacs ; then
		pushd lib/tools/emacs
		elisp-compile *.el
		popd
	fi
}

src_install() {
	local ERL_LIBDIR=/usr/$(get_libdir)/erlang

	make INSTALL_PREFIX="${D}" install || die
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
	grep -rle "${D}" "${D}"/${ERL_LIBDIR}/erts-* | xargs sed -i -e "s:${D}::g"

	## Clean up the no longer needed files
	rm "${D}"/${ERL_LIBDIR}/Install

	if use doc ; then
		for file in "${WORKDIR}"/man/man*/*.[1-9]; do
			# Avoid namespace collisions
			local newfile=${file}erl
			cp $file $newfile
			# Man page processing tools expect a capitalized "SEE ALSO" section
			# header
			sed -i -e 's,\.SH See Also,\.SH SEE ALSO,g' $newfile
			doman ${newfile}
		done
		dohtml -A README,erl,hrl,c,h,kwc,info -r "${WORKDIR}"/doc "${WORKDIR}"/lib "${WORKDIR}"/erts-*
	fi

	if use emacs ; then
		pushd "${S}"
		elisp-install erlang lib/tools/emacs/*.{el,elc}
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
		popd
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
