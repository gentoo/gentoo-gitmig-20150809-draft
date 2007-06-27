# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/bigloo/bigloo-2.9a.ebuild,v 1.6 2007/06/27 06:53:18 opfer Exp $

inherit elisp-common multilib

MY_P=${PN}${PV/_p/-}

DESCRIPTION="Bigloo is a Scheme implementation."
HOMEPAGE="http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo.html"
SRC_URI="ftp://ftp-sop.inria.fr/mimosa/fp/Bigloo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

DEPEND="emacs? ( virtual/emacs )"

S=${WORKDIR}/${MY_P%-*}

SITEFILE="50bigloo-gentoo.el"

IUSE="emacs"
# fullbee"

src_compile() {
	use emacs && elisp-comp etc/*.el

	# Bigloo doesn't use autoconf and consequently a lot of options used by econf give errors
	# Manuel Serrano says: "Please, dont talk to me about autoconf. I simply dont want to hear about it..."
	./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
		--libdir=/usr/$(get_libdir) \
		--docdir=/usr/share/doc/${PF} \
		--benchmark=yes \
		--sharedbde=no \
		--sharedcompiler=no \
		--coflags="" || die "configure failed"

#		--bee=$(if use fullbee; then echo full; else echo partial; fi) \

	# parallel build is broken
	emake -j1 || die "emake failed"
}

# "make test" does something weird so default src_test() in /usr/lib/portage/bin/ebuild.sh fails the following test
# elif emake -j1 test -n &> /dev/null; then
# so copy straight from default src_test() all the stuff which depends on that test passing
src_test() {
	vecho ">>> Test phase [test]: ${CATEGORY}/${PF}"
	if ! emake -j1 test; then
		hasq test $FEATURES && die "Make test failed. See above for details."
		hasq test $FEATURES || eerror "Make test failed. See above for details."
	fi
}

src_install () {
#	dodir /etc/env.d
#	echo "LDPATH=/usr/$(get_libdir)/bigloo/${PV}/" > ${D}/etc/env.d/25bigloo

	# make the links created not point to DESTDIR, since that is only a temporary home
	sed 's/ln -s $(DESTDIR)/ln -s /' -i Makefile.misc
	emake DESTDIR=${D} install || die "install failed"

	if use emacs; then
		elisp-install ${PN} etc/*.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

#	einfo "Compiling bee..."
#	emake compile-bee || die "compiling bee failed"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
