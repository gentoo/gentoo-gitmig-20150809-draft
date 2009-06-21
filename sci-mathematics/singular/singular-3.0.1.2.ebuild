# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/singular/singular-3.0.1.2.ebuild,v 1.11 2009/06/21 18:50:13 graaff Exp $

inherit eutils flag-o-matic

PV_MAJOR=${PV%.*}
MY_PV=${PV//./-}
MY_PN=${PN/s/S}
MY_PV_MAJOR=${MY_PV%-*}

DESCRIPTION="Computer algebra system for polynomial computations"
HOMEPAGE="http://www.singular.uni-kl.de/"
SRC_URI="ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/$MY_PV_MAJOR/${MY_PN}-${MY_PV}.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/UNIX/${MY_PN}-3-0-1-share.tar.gz"

LICENSE="singular"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="doc emacs"

DEPEND=">=dev-lang/perl-5.6
		>=dev-libs/gmp-4.1-r1
		emacs? ( || ( app-editors/xemacs
					virtual/emacs ) )"

S="${WORKDIR}"/${MY_PN}-${MY_PV_MAJOR}

src_unpack () {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-${PV_MAJOR}-gentoo.diff
	epatch "${FILESDIR}"/${P}-gcc4.1-gentoo.patch
	sed -e "s/PFSUBST/${PF}/" -i "${S}"/kernel/feResource.cc || \
		die "sed failed on feResource.cc"
}

src_compile() {
	# need to filter this LDFLAGS, otherwise the configure
	# script chokes (see bug #125180)
	filter-flags -Wl,-hashvals
	filter-ldflags -hashvals
	filter-ldflags -Wl,-hashvals

	local myconf="${myconf} --disable-doc --without-MP --with-factory --with-libfac --prefix=${S}"
	econf $(use_enable emacs) \
		${myconf} || die "econf failed"
	emake -j1 || die "make failed"
}

src_install () {
	local myarchprefix
	case ${ARCH} in
		x86)
			myarchprefix=ix86
			;;
		*)
			myarchprefix=${ARCH}
			;;
	esac

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

	cd "${S}/${myarchprefix}"-Linux

	# install binaries
	rm ${MY_PN} || die "failed to remove ${MY_PN}"
	dobin ${MY_PN}* gen_test change_cost solve_IP \
		toric_ideal LLL || die "failed to install binaries"

	if use emacs; then
		dobin E${MY_PN} || die "failed to install ESingular"
	fi

	# install libraries
	insinto /usr/lib/${PN}
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
