# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/singular/singular-2.0.4-r1.ebuild,v 1.4 2004/04/01 08:47:22 phosphan Exp $

inherit eutils

MINPV=${PV//./-}
BPN=${PN/s/S}
DESCRIPTION="computer algebra system for polynomial computations"
SRC_URI="ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-doc-${MINPV}.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-emacs-${MINPV}.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-factory-${MINPV}b.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-IntProg-${MINPV}a.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-kernel-${MINPV}a.tar.gz
		ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-libfac-${MINPV}b.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-main-${MINPV}c.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-MP-${MINPV}.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-NTL-5.2.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-NTL-generic.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-omalloc-${MINPV}.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/src/${BPN}-Tst-${MINPV}a.tar.gz"
HOMEPAGE="http://www.singular.uni-kl.de/"

RDEPEND=">=dev-lang/perl-5.6
		>=dev-libs/gmp-4.1-r1"

IUSE="doc"

DEPEND="${RDEPEND}
		doc? ( sys-apps/texinfo
				virtual/tetex
				dev-lang/perl )"

SLOT="0"
LICENSE="singular"
KEYWORDS="x86 ppc"

S=${WORKDIR}

src_unpack () {
	unpack ${A}
	epatch  $FILESDIR/singular-2.0.4-gentoo.diff
}



src_compile() {
	local myconf="${myconf} --with-NTL --prefix=${D}/usr"
	econf ${myconf}
	make CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "make failed"
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
	cd ${WORKDIR}/omalloc
	einstall || die
	cd ${WORKDIR}/MP
	einstall || die
	cd ${WORKDIR}/ntl
	einstall || die
	cd ${WORKDIR}/factory
	einstall || die
	cd ${WORKDIR}/libfac
	einstall || die
	cd ${WORKDIR}/Singular
	einstall || die
	rm ${D}/usr/LIB
	dodir /usr/share/singular/LIB
	dodir /usr/share/singular/LIB/gftables
	insinto /usr/share/singular/LIB
	cd ${WORKDIR}/Singular/LIB
	doins *.lib*
	insinto /usr/share/singular/LIB/gftables
	cd gftables
	doins *
	dodir /usr/bin
	dodir /usr/lib/singular
	insinto /usr/lib/singular
	cd ${D}/usr/${myarchprefix}-Linux
	rm Singular
	dobin *Singular*
	doins *.so
	use doc && 	( 	cd ${WORKDIR}/doc
					# fake ssh during doc creation
					cp ${FILESDIR}/fake_ssh ${T}/ssh
					chmod +x ${T}/ssh
					export PATH="${T}:${PATH}"
					make dvi
					dodoc *.dvi
					make ps
					dodoc *.ps
					local strange_error="Inappropriate ioctl for device"
					echo ${strange_error} > makeresult
					while grep -q "${strange_error}" makeresult
					do make 2>&1 info | tee makeresult
					done
					echo > singular.info "INFO-DIR-SECTION Math"
					echo >> singular.info "START-INFO-DIR-ENTRY"
					echo >> singular.info "* Singular: (singular).         A Computer Algebra System for Polynomial Computations"
					echo >> singular.info "END-INFO-DIR-ENTRY"
					cat singular.hlp >> singular.info
					doinfo singular.info
					make html
					dohtml -r html/.
					cd ${D}/usr
					mv doc/NTL share/doc/${PF}/
				)
	cd ${D}
	dosym /usr/bin/Singular-2-0-4 /usr/bin/Singular
	cd ${D}/usr
	rm -r ${myarchprefix}-Linux
}

pkg_postinst() {
	einfo "The authors ask you to register as a SINGULAR user."
	einfo "Please check the license file for details."
}
