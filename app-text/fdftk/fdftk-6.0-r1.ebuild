# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fdftk/fdftk-6.0-r1.ebuild,v 1.5 2004/07/21 19:54:38 mr_bones_ Exp $

MY_P="FDFToolkitForUnix"
At="${MY_P}.tar.gz"

DESCRIPTION="Acrobat FDF Toolkit"
HOMEPAGE="http://partners.adobe.com/asn/acrobat/forms.jsp"
SRC_URI="${At}"

SLOT="0"
LICENSE="Adobe"
KEYWORDS="-* x86" # binaries for i386 type hardware ONLY
RESTRICT="fetch nostrip nomirror"

#DEPEND="virtual/libc
#		perl? ( dev-lang/perl )"
IUSE=""

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
	dolib.so "Headers and Libraries/LINUX/libFdfTk.so" || die
	insinto /opt/${P}/include
	doins "Headers and Libraries/Headers/FdfTk.h" || die
	# It doesn't support Perl 5.8.*
	#if use perl; then
	#	eval `perl '-V:package'`
	#	eval `perl '-V:version'`
	#	eval `perl '-V:archname'`
	#	insinto /usr/lib/${package}/vendor_perl/${version}/Acrobat
	#	exeinto /usr/lib/${package}/vendor_perl/${version}/${archname}/auto/Acrobat/FDF
	#	doexe "Headers and Libraries/LINUX/FDF.so" || die
	#	doins "Headers and Libraries/Headers/FDF.pm" || die
	#fi

	into /usr
	dodoc ReadMe.txt Documentation/*.pdf

	dodir /etc/env.d
	echo "LDPATH=/opt/${P}/lib" >${D}/etc/env.d/55${P}
}
