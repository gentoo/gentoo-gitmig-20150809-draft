# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fdftk/fdftk-6.0.ebuild,v 1.1 2004/03/10 05:38:09 robbat2 Exp $

IUSE="perl"

MY_P="FDFToolkitForUnix"
At="${MY_P}.tar.gz"

DESCRIPTION="Acrobat FDF Toolkit"
HOMEPAGE="http://partners.adobe.com/asn/acrobat/forms.jsp"
SRC_URI="${At}"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="-* ~x86" # binaries for i386 type hardware ONLY
RESTRICT="fetch"

DEPEND="virtual/glibc
	perl? ( dev-lang/perl )"

S=${WORKDIR}/${MY_P}

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	unpack ${At} || die
}

src_install () {
	into /opt/${P}
	dolib.so "Headers and Libraries/LINUX/FDF.so" || die
	dolib.so "Headers and Libraries/LINUX/libFdfTk.so" || die
	insinto /opt/${P}/include
	doins "Headers and Libraries/Headers/FdfTk.h" || die

	if use perl; then
		eval `perl '-V:package'`
		eval `perl '-V:version'`
		insinto /usr/lib/${package}/vendor_perl/${version}/Acrobat
		doins "Headers and Libraries/Headers/FDF.pm" || die
	fi

	into /usr
	dodoc ReadMe.txt Documentation/*.pdf

	dodir /etc/env.d
	echo "LDPATH=/opt/${P}/lib" >${D}/etc/env.d/55${P}
}
