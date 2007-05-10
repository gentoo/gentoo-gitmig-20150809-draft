# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-2.6.ebuild,v 1.1 2007/05/10 12:53:07 hkbst Exp $

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
		emacs? ( virtual/emacs )"

SITEFILE=50hen-gentoo.el

src_unpack() {
	unpack ${P}.tar.gz
#	cp ${DISTDIR}/syntax-case.egg ${S}
#	mkdir ${S}/syntax-case.egg-dir
#	tar xzf ${DISTDIR}/syntax-case.egg -C ${S}/syntax-case.egg-dir
#	sed -e "s_csi_../csi_" -e "s_csc_../csc_" -i ${S}/syntax-case.egg-dir/syntax-case.setup
}

src_compile() {
	econf --disable-apply-hook --disable-procedure-tables || die "./configure failed"
	make || die "make failed"

	use emacs && elisp-comp hen.el
}

# chicken doesn't seem to honor CHICKEN_PREFIX CHICKEN_HOME or LD_LIBRARY_PATH=${S}/.libs/
RESTRICT=test
#src_test() {
#	cd tests
#	bash runtests.sh
#}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog* README NEWS
	dohtml -r html/
	rm -rf ${D}/usr/share/chicken/doc

	if use emacs; then
		elisp-install ${PN} *.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi

	dodir /usr/$(get_libdir)/chicken/1/syntax-case.egg-dir
	tar xzf ${DISTDIR}/syntax-case.egg -C ${D}/usr/$(get_libdir)/chicken/1/syntax-case.egg-dir

#	insinto /usr/$(get_libdir)/chicken/1/
#	doins ${DISTDIR}/syntax-case.egg
}

pkg_postinst() {
	chicken-setup syntax-case
	use emacs && elisp-site-regen
}

pkg_prerm() {
	chicken-setup -uninstall syntax-case
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
