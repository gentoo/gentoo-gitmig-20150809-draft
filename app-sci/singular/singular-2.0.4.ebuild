# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/singular/singular-2.0.4.ebuild,v 1.1 2003/10/24 10:13:41 phosphan Exp $

S=${WORKDIR}/${P}
MINPV=${PV//./-}
BPN=${PN/s/S}
DESCRIPTION="Singular"
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

DEPEND=">=dev-lang/perl-5.6
		>=dev-libs/gmp-4.1-r1"

SLOT="0"
LICENSE="singular"
KEYWORDS="~x86 ~ppc"

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
	dosym /usr/bin/Singular-2-0-4 /usr/bin/Singular
	cd ${D}/usr
	rm -r ${myarchprefix}-Linux
}
