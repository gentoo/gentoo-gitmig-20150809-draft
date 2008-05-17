# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/singular/singular-3.0.4.2.ebuild,v 1.2 2008/05/17 09:42:07 markusle Exp $

inherit eutils elisp-common flag-o-matic autotools multilib

PV_MAJOR=${PV%.*}
MY_PV=${PV//./-}
MY_PN=${PN/s/S}
MY_PV_MAJOR=${MY_PV%-*}

DESCRIPTION="Computer algebra system for polynomial computations"
HOMEPAGE="http://www.singular.uni-kl.de/"
SRC_URI="http://www.mathematik.uni-kl.de/ftp/pub/Math/Singular/SOURCES/3-0-4/${MY_PN}-${MY_PV}.tar.gz
	http://www.mathematik.uni-kl.de/ftp/pub/Math/Singular/UNIX/${MY_PN}-${MY_PV}-share.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc emacs boost"

DEPEND=">=dev-lang/perl-5.6
		>=dev-libs/gmp-4.1-r1
		emacs? ( virtual/emacs )
		boost? ( dev-libs/boost )"

S="${WORKDIR}"/${MY_PN}-${MY_PV_MAJOR}
SITEFILE=60${PN}-gentoo.el

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-gentoo.diff

	cd "${S}"/kernel
	sed -e "s/PFSUBST/${PF}/" -i feResource.cc || \
		die "sed failed on feResource.cc"

	cd "${S}"/Singular
	if ! use boost; then
		sed -e "s/AC_CHECK_HEADERS(boost/#AC_CHECK_HEADERS(boost/" \
			-i configure.in || \
			die "failed to fix detection of boost headers"
	else
		# -no-exceptions and boost don't play well
		sed -e "/CXXFLAGS/ s/--no-exceptions//g" \
			-i configure.in || \
			die "sed failed on configure"
	fi
	eautoconf
}

src_compile() {
	local myconf="${myconf} --disable-doc --without-MP --with-factory --with-libfac --with-gmp --prefix=${S}"
	econf $(use_enable emacs) \
		${myconf} || die "econf failed"
	emake -j1 || die "make failed"

	if use emacs; then
		cd "${WORKDIR}"/${MY_PN}/${MY_PV_MAJOR}/emacs/
		elisp-compile *.el || die "elisp-compile failed"
	fi
}

src_install () {
	# install basic docs
	cd "${S}" && dodoc BUGS ChangeLog || \
		die "failed to install docs"

	# install data files
	insinto /usr/share/${PN}/LIB
	cd "${S}"/${MY_PN}/LIB && doins *.lib COPYING help.cnf || \
		die "failed to install lib files"
	insinto /usr/share/${PN}/LIB/gftables
	cd gftables && doins * \
		|| die "failed to install files int LIB/gftables"

	cd "${S}"/*-Linux

	# install binaries
	rm ${MY_PN} || die "failed to remove ${MY_PN}"
	dobin ${MY_PN}* gen_test change_cost solve_IP \
		toric_ideal LLL || die "failed to install binaries"

	# install libraries
	insinto /usr/$(get_libdir)/${PN}
	doins *.so || die "failed to install libraries"

	# create symbolic link
	dosym /usr/bin/${MY_PN}-${MY_PV_MAJOR} /usr/bin/${MY_PN} || \
		die "failed to create symbolic link"

	# install examples
	cd "${WORKDIR}"/${MY_PN}/${MY_PV_MAJOR}
	insinto /usr/share/${PN}/examples
	doins examples/* || die "failed to install examples"

	# install extended docs
	if use doc; then
		dohtml -r html/* || die "failed to install html docs"

		insinto /usr/share/${PN}
		doins doc/singular.idx || die "failed to install idx file"

		cp info/${PN}.hlp info/${PN}.info &&
		doinfo info/${PN}.info || \
		die "failed to install info files"
	fi

	# install emacs specific stuff here, as we did a directory change
	# some lines above!
	if use emacs; then
		elisp-install ${PN} emacs/*.el emacs/*.elc emacs/.emacs* || \
		die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	einfo "The authors ask you to register as a SINGULAR user."
	einfo "Please check the license file for details."

	if use emacs; then
		echo
		ewarn "Please note that the ESingular emacs wrapper has been"
		ewarn "removed in favor of full fledged singular support within"
		ewarn "Gentoo's emacs infrastructure; i.e. just fire up emacs"
		ewarn "and you should be good to go! See bug #193411 for more info."
		echo
	fi

	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
