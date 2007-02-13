# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cm/cm-2.10.0.ebuild,v 1.2 2007/02/13 12:07:26 hkbst Exp $

inherit elisp-common

DESCRIPTION="Common Music: An object oriented music composition environment in LISP/scheme"
HOMEPAGE="http://commonmusic.sourceforge.net"
SRC_URI="mirror://sourceforge/commonmusic/${P}.tar.gz"

LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

COMPILERS="dev-lisp/openmcl
	dev-lisp/sbcl
	dev-lisp/cmucl
	dev-lisp/clisp"

INTERPRETERS="dev-lisp/ecls
	dev-scheme/guile
	dev-scheme/gauche"

DEPEND="|| ( ${COMPILERS} ${INTERPRETERS} )
	emacs? ( virtual/emacs app-emacs/slime )"
RDEPEND="${DEPEND}"

IUSE="doc emacs"

S="${WORKDIR}/${PN}"

SITEFILE="71cm-gentoo.el"

# for easy testing of any implementation
#FORCEIMPL="guile"
FORCEIMPL=""

CM="${S}/bin/cm.sh -R . -l \"\${FORCEIMPL}\""
#echo "${CM}"

implementation() {
	if [[ ! -z "${FORCEIMPL}" ]]; then
		echo "${FORCEIMPL}"
		return
	fi
	local impl=$(${PN} -nv | grep Executable)
	impl=${impl##*bin/}
	echo ${impl}
}

lisp?() {
	local impl="$(implementation)"
#	echo ${impl}
	if [[ ${impl} == "guile" || ${impl} == "gauche" ]]; then
		return $(false)
	fi
	return $(true)
}

compiler?() {
	local impl="$(implementation)"
#	echo ${impl}
	if [[ -z $(echo ${COMPILERS} | grep -i ${impl}) ]]; then
		return $(false)
	fi
	return $(true)
}

src_compile() {
	use emacs && elisp-comp etc/xemacs/*.el

	einfo "Detected $(compiler? && echo "compiler" || echo "interpreter"): $(implementation)"

	if compiler?; then
		einfo "Byte-compiling code and generating Lisp code"
		echo '(quit)' | eval ${CM}
		echo -e "\n"
		einfo "Byte-compiling generated code"
		echo '(quit)' | eval ${CM}
	fi
}

src_test() {
#	echo   "(if '()\
#		(begin (display \"scheme\") (load \"etc/test.cm\") (test-cm))\
#		(progn (format t \"commonlisp\") (load \"etc/test.cm\") (test-cm)))"\
#		| eval ${CM}

	echo '(load "etc/test.cm")(test-cm)' | eval ${CM}
}

src_install() {
	insinto /usr/share/${PN}/
	for dir in "bin etc src"; do
		doins -r ${dir}
	done;
	doins cm.asd
	chmod +x ${D}/usr/share/${PN}/bin/cm.sh
	dosym /usr/share/${PN}/bin/cm.sh /usr/bin/${PN}

	mv doc/changelog.text .
	dodoc readme.text changelog.text

	use doc && dohtml -r doc/*

	if use emacs; then
		elisp-install ${PN} etc/xemacs/*.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	# make compiled lisp code newer than source files to prevent recompilation 
	find ${ROOT}/usr/share/${PN}/bin/ -iname *fasl -exec touch '{}' \;
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

