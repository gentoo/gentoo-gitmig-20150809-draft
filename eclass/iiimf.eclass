# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/iiimf.eclass,v 1.7 2004/09/13 20:11:13 usata Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The IIIMF eclass is used for compilation and installation of IIIMF
# libraries, servers, clients and modules within the Portage system.
#

ECLASS=iiimf
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS src_compile src_install

snapshot() {
	if [ "${PV:0:2}" -eq 12 ] ; then
		true
	else
		false
	fi
}

IMSDK_PV="r${PV//./_}"
if snapshot ; then
	MY_INFIX="-src-"
	MY_PV="${IMSDK_PV/_pre/-svn}"
	MY_SUFFIX="tgz"
else
	MY_INFIX="."
	MY_PV="${IMSDK_PV/_p/.}"
	MY_SUFFIX="tar.bz2"
fi
IMSDK_P="im-sdk${MY_INFIX}${MY_PV}"
IMSDK="im-sdk-${MY_PV/./-}"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://www.openi18n.org/subgroups/im/IIIMF/"
SRC_URI="http://www.openi18n.org/download/docs/im-sdk/${IMSDK_P}.${MY_SUFFIX}"

LICENSE="MIT X11"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="virtual/libc"

S="${WORKDIR}/${IMSDK}/${PN}"

iiimf_src_compile() {

	snapshot && ./autogen.sh

	econf --enable-optimize \
		`use_enable debug` || die
	# emake doesn't work on some libraries
	emake -j1 || die
}

iiimf_src_install() {

	einstall || die

	dodoc ChangeLog
}

