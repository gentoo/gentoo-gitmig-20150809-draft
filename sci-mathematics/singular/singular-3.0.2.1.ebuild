# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/singular/singular-3.0.2.1.ebuild,v 1.3 2007/07/13 05:28:09 mr_bones_ Exp $

inherit eutils flag-o-matic autotools multilib

PV_MAJOR=${PV%.*}
MY_PV=${PV//./-}
MY_PN=${PN/s/S}
MY_PV_MAJOR=${MY_PV%-*}

DESCRIPTION="Computer algebra system for polynomial computations"
HOMEPAGE="http://www.singular.uni-kl.de/"
SRC_URI="ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/$MY_PV_MAJOR/${MY_PN}-${MY_PV}.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/UNIX/${MY_PN}-3-0-2-share.tar.gz"

LICENSE="singular"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc emacs boost"

DEPEND=">=dev-lang/perl-5.6
		>=dev-libs/gmp-4.1-r1
		emacs? ( || ( virtual/xemacs
					virtual/emacs ) )
		boost? ( dev-libs/boost )"

S="${WORKDIR}"/${MY_PN}-${MY_PV_MAJOR}

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-${PV_MAJOR}-gentoo.diff

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

	if use emacs; then
		dobin E${MY_PN} || die "failed to install ESingular"
	fi

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

		cp info/${PN}.hlp info/${PN}.info &&
		doinfo info/${PN}.info || \
		die "failed to install info files"
	fi

	# install emacs specific stuff
	if use emacs; then
		insinto /usr/share/${PN}/emacs
		doins emacs/* && doins emacs/.emacs* || \
		die "failed to set up emacs files"
	fi
}

pkg_postinst() {
	einfo "The authors ask you to register as a SINGULAR user."
	einfo "Please check the license file for details."
}
