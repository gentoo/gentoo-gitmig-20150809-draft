# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/singular/singular-3.1.1-r1.ebuild,v 1.1 2010/10/17 08:20:13 xarthisius Exp $

EAPI="2"

inherit autotools eutils elisp-common flag-o-matic multilib versionator

MY_PN=Singular
MY_PV=$(replace_all_version_separators -)
MY_PV_SHARE=${MY_PV}

DESCRIPTION="Computer algebra system for polynomial computations"
HOMEPAGE="http://www.singular.uni-kl.de/"
SRC_COM="http://www.mathematik.uni-kl.de/ftp/pub/Math/${MY_PN}/SOURCES/${MY_PV}/${MY_PN}"
SRC_URI="${SRC_COM}-${MY_PV}.tar.gz ${SRC_COM}-${MY_PV_SHARE}-share.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="boost doc emacs examples"

RDEPEND="dev-libs/gmp
	>=dev-libs/ntl-5.5.1
	emacs? ( >=virtual/emacs-22 )"

DEPEND="${RDEPEND}
	dev-lang/perl
	boost? ( dev-libs/boost )"

S="${WORKDIR}"/${MY_PN}-${MY_PV}
SITEFILE=60${PN}-gentoo.el

src_prepare () {
	epatch "${FILESDIR}"/${PN}-3.1.0-gentoo.patch
	epatch "${FILESDIR}"/${PN}-3.1.0-emacs-22.patch
	epatch "${FILESDIR}"/${PN}-3.1.0-glibc-2.10.patch
	epatch "${FILESDIR}"/${PN}-3.0.4.4-nostrip.patch

	sed -i \
		-e "s/PFSUBST/${PF}/" \
		kernel/feResource.cc || die

	sed -i \
		-e '/CXXFLAGS/ s/--no-exceptions//g' \
		-e "s/SLDFLAGS=-shared/SLDFLAGS=\"$(raw-ldflags) -shared\"/" \
		"${S}"/Singular/configure.in || die

	cd "${S}"/Singular || die
	eautoconf
}

src_configure() {
	econf \
		--prefix="${S}" \
		--disable-debug \
		--disable-doc \
		--disable-NTL \
		--disable-gmp \
		--without-MP \
		--enable-factory \
		--enable-libfac \
		--enable-IntegerProgramming \
		--enable-Singular \
		$(use_with boost Boost) \
		$(use_enable emacs)
}

src_compile() {
	emake -j1 || die
	if use emacs; then
		cd "${WORKDIR}"/${MY_PN}/${MY_PV}/emacs/
		elisp-compile *.el || die
	fi
}

src_install () {
	dodoc README || die
	# execs and libraries
	cd "${S}"/*-Linux
	dobin ${MY_PN}* gen_test change_cost solve_IP toric_ideal LLL \
		|| die
	insinto /usr/$(get_libdir)/${PN}
	doins *.so || die

	dosym ${MY_PN}-${MY_PV} /usr/bin/${MY_PN} || die

	# stuff from the share tar ball
	cd "${WORKDIR}"/${MY_PN}/${MY_PV}
	insinto /usr/share/${PN}
	doins -r LIB  || die
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
	if use doc; then
		dohtml -r html/* || die
		insinto /usr/share/${PN}
		doins doc/singular.idx || die
		cp info/${PN}.hlp info/${PN}.info &&
		doinfo info/${PN}.info || die
	fi
	if use emacs; then
		elisp-install ${PN} emacs/*.el emacs/*.elc emacs/.emacs* \
			|| die
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
