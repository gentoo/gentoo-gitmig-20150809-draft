# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/bigloo/bigloo-3.2b_p2.ebuild,v 1.1 2009/06/04 12:21:37 hkbst Exp $

inherit elisp-common multilib eutils

MY_P=${PN}${PV/_p/-}
MY_P=${MY_P/_alpha/-alpha}
MY_P=${MY_P/_beta/-beta}

DESCRIPTION="Bigloo is a Scheme implementation."
HOMEPAGE="http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo.html"
SRC_URI="ftp://ftp-sop.inria.fr/mimosa/fp/Bigloo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

# bug 254916 for >=dev-libs/boehm-gc-7.1
DEPEND=">=dev-libs/boehm-gc-7.1
		emacs? ( virtual/emacs )
		java? ( virtual/jdk app-arch/zip )"

RDEPEND="dev-libs/boehm-gc"

S=${WORKDIR}/${MY_P%-*}

SITEFILE="50bigloo-gentoo.el"

IUSE="bee emacs java"

src_compile() {
	# Bigloo doesn't use autoconf and consequently a lot of options used by econf give errors
	# Manuel Serrano says: "Please, dont talk to me about autoconf. I simply dont want to hear about it..."
	./configure \
		$(use java && echo "--jvm=yes --java=$(java-config --java) --javac=$(java-config --javac)") \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libdir=/usr/$(get_libdir) \
		--docdir=/usr/share/doc/${PF} \
		--benchmark=yes \
		--sharedbde=no \
		--sharedcompiler=no \
		--customgc=no \
		--coflags="" \
		--bee=$(if use bee; then echo full; else echo partial; fi)

	emake || die "emake failed"

	if use bee; then
		einfo "Compiling bee..."
		emake compile-bee || die "compiling bee failed"
	fi

	if use emacs; then
		elisp-compile etc/*.el || die "elisp-compile failed"
	fi
}

# default thinks that target doesn't exist
src_test() {
	vecho ">>> Test phase [test]: ${CATEGORY}/${PF}"
	emake test || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	if use bee; then
		emake DESTDIR="${D}" install-bee || die
	fi

	if use emacs; then
		elisp-install ${PN} etc/*.{el,elc} || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
