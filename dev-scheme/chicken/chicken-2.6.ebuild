# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-2.6.ebuild,v 1.3 2007/09/06 15:08:41 hkbst Exp $

inherit multilib elisp-common

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz
		 http://www.call-with-current-continuation.org/eggs/syntax-case.egg"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs"

DEPEND="dev-libs/libpcre
		|| ( dev-libs/g-wrap dev-libs/libffi )
		emacs? ( virtual/emacs )"

SITEFILE=50hen-gentoo.el

src_unpack() {
	unpack ${P}.tar.gz
	mkdir ${S}/syntax-case && tar xzf ${DISTDIR}/syntax-case.egg -C ${S}/syntax-case
#	sed -e "s_csi_../csi_g" -e "s_csc_../csc_g" -i ${S}/syntax-case/syntax-case.setup
}

src_compile() {
	econf --disable-apply-hook --disable-procedure-tables || die "configure failed"
	emake || die "make failed"

	use emacs && elisp-comp hen.el
}

# chicken doesn't seem to honor CHICKEN_PREFIX CHICKEN_HOME or LD_LIBRARY_PATH=${S}/.libs/
RESTRICT=test
#src_test() {
#	cd tests
#	bash runtests.sh
#}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog* README NEWS
	dohtml -r html/
	rm -rf ${D}/usr/share/chicken/doc

	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	chicken-setup -v -local ${S} syntax-case
	use emacs && elisp-site-regen
}

pkg_prerm() {
	rm -rf /usr/$(get_libdir)/chicken/1/*
#	chicken-setup -v -uninstall syntax-case
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
