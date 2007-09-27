# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/hop/hop-1.7.0.ebuild,v 1.2 2007/09/27 08:21:51 opfer Exp $

inherit elisp-common multilib

DESCRIPTION="Hop is a higher-order language for programming interactive web applications such as web agendas, web galleries, music players, etc. that is implemented as a Web broker"
HOMEPAGE="http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo.html"
SRC_URI="ftp://ftp-sop.inria.fr/mimosa/fp/Hop/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-scheme/bigloo-3.0b"

#S=${WORKDIR}/${MY_P%-*}

#SITEFILE="50bigloo-gentoo.el"

IUSE=""

src_unpack(){
	unpack ${A}; cd "${S}"

#	cp runtime/Makefile runtime/Makefile.old

#	sed "/BOOT/d" "$(bigloo -q -eval "(begin (print *default-lib-dir*) (exit 0))")"/Makefile.config > "${T}"/Makefile.config
#	sed "s#include \$(BIGLOOLIBDIR)/Makefile.config#include \"${T}\"/Makefile.config#" -i runtime/Makefile

#	sed "s#-include \$(BIGLOOLIBDIR)/Makefile.config##" -i runtime/Makefile

#	sed "/include \$(BIGLOOLIBDIR)\/Makefile.config/aBIGLOO=bigloo" -i hopscheme/Makefile Makefile runtime/Makefile scheme2js/Makefile

	sed "/include \$(BIGLOOLIBDIR)\/Makefile.config/aBIGLOO=bigloo" -i */Makefile Makefile

#	diff -u runtime/Makefile.old runtime/Makefile

#	cp weblets/Makefile weblets/Makefile.old

	sed -e "/mkdir -p \$(HOPWEBLETSDIR)/d" \
		-e "/chmod a+rx \$(HOPWEBLETSDIR)/d" -i weblets/Makefile

#	diff -u weblets/Makefile.old weblets/Makefile
}

src_compile() {
	# Hop doesn't use autoconf and consequently a lot of options used by econf give errors
	# Manuel Serrano says: "Please, dont talk to me about autoconf. I simply dont want to hear about it..."
	./configure --prefix=/usr --libdir=/usr/$(get_libdir) || die "configure failed"

	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
}
