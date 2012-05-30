# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cvc3/cvc3-2.4.1.ebuild,v 1.1 2012/05/30 00:51:22 gienah Exp $

EAPI="4"

inherit elisp-common

DESCRIPTION="CVC3 is an automatic theorem prover for Satisfiability Modulo Theories (SMT) problems"
HOMEPAGE="http://www.cs.nyu.edu/acsys/cvc3/index.html"
SRC_URI="http://www.cs.nyu.edu/acsys/cvc3/releases/2.4.1/${P}.tar.gz"

LICENSE="CVC3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc emacs isabelle static-libs zchaff"

RDEPEND=""
DEPEND="${RDEPEND}
		>=dev-libs/gmp-5[static-libs?]
		doc? (
			app-doc/doxygen
			media-gfx/graphviz
		)
		emacs? (
			virtual/emacs
		)
		isabelle? (
			>=sci-mathematics/isabelle-2011.1-r1
		)"

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	sed -e 's/prefix=@prefix@/prefix=${DESTDIR}@prefix/' \
		-e 's/libdir=@libdir@/libdir=${DESTDIR}@libdir/' \
		-e 's/mandir=@mandir@/mandir=${DESTDIR}@mandir@/' \
		-i "${S}/Makefile.local.in" \
		|| die "Could not set DESTDIR in Makefile.local.in"
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable zchaff)

	if use test; then
		sed -e 's@LD_LIBS = @LD_LIBS = -L'"${S}"'/lib -Wl,-R'"${S}"'/lib @' \
			-i "${S}/test/Makefile" \
			|| die "Could not set library paths in test/Makefile"
	fi
}

src_compile() {
	emake

	if use doc; then
		pushd doc || die "Could not cd to doc"
		emake
		popd
	fi

	if use emacs ; then
		pushd "${S}/emacs" || die "Could change directory to emacs"
		elisp-compile *.el || die "emacs elisp compile failed"
		popd
	fi

	if use test; then
		pushd test || die "Could not cd to test"
		emake
		popd
	fi
}

src_test() {
	pushd test || die "Could not cd to test"
	./bin/test || die "tests failed"
	popd
}

src_install() {
	emake DESTDIR="${D}" install

	if use doc; then
		pushd "${S}"/doc/html || die "Could not cd to doc/html"
		dohtml *.html
		insinto /usr/share/doc/${PF}/html
		doins *.css *.gif *.png
		popd
	fi

	if use emacs ; then
		elisp-install ${PN} emacs/*.{el,elc}
		cp "${FILESDIR}"/${SITEFILE} "${S}"
		elisp-site-file-install ${SITEFILE}
	fi

	if use isabelle; then
		ISABELLE_HOME="$(isabelle getenv ISABELLE_HOME | cut -d'=' -f 2)" \
			|| die "isabelle getenv ISABELLE_HOME failed"
		if [[ -z "${ISABELLE_HOME}" ]]; then
			die "ISABELLE_HOME empty"
		fi
		dodir "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		cat <<- EOF >> "${S}/settings"
			CVC3_COMPONENT="\$COMPONENT"
			CVC3_HOME="${ROOT}usr/bin"
			CVC3_SOLVER="\$CVC3_HOME/cvc3"
			CVC3_REMOTE_SOLVER="cvc3"
			CVC3_INSTALLED="yes"
		EOF
		insinto "${ISABELLE_HOME}/contrib/${PN}-${PV}/etc"
		doins "${S}/settings"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	if use isabelle; then
		if [ -f "${ROOT}etc/isabelle/components" ]; then
			if egrep "contrib/${PN}-[0-9.]*" "${ROOT}etc/isabelle/components"; then
				sed -e "/contrib\/${PN}-[0-9.]*/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
			cat <<- EOF >> "${ROOT}etc/isabelle/components"
				contrib/${PN}-${PV}
			EOF
		fi
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
	if use isabelle; then
		if [ ! -f "${ROOT}usr/bin/cvc3" ]; then
			if [ -f "${ROOT}etc/isabelle/components" ]; then
				# Note: this sed should only match the version of this ebuild
				# Which is what we want as we do not want to remove the line
				# of a new E being installed during an upgrade.
				sed -e "/contrib\/${PN}-${PV}/d" \
					-i "${ROOT}etc/isabelle/components"
			fi
		fi
	fi
}
