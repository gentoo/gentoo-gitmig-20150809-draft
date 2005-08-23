# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/sather/sather-1.3.ebuild,v 1.17 2005/08/23 17:59:01 flameeyes Exp $

inherit eutils

MY_P="Sather-${PV}"
DESCRIPTION="object oriented language designed to be simple, efficient, safe, flexible and non-proprietary"
HOMEPAGE="http://www.icsi.berkeley.edu/~sather/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	ftp://ftp.gnu.org/gnu/${PN}/Doc/${PN}-tutorial-000328.ps.gz
	ftp://ftp.gnu.org/gnu/${PN}/Doc/${PN}-tutorial-000328.html.tar.gz
	ftp://ftp.gnu.org/gnu/${PN}/Doc/${PN}-specification-000328.html.tar.gz
	ftp://ftp.gnu.org/gnu/${PN}/Doc/${PN}-specification-000328.ps.gz
	http://www.icsi.berkeley.edu/~${PN}/Publications/satish-thatte.ps.gz
	http://www.icsi.berkeley.edu/~${PN}/Documentation/LanguageDescription/Descript.ps.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 sparc"
IUSE=""

DEPEND=">=sys-devel/gcc-2.95.3-r5
	>=dev-libs/boehm-gc-6.0"
RDEPEND=">=sys-devel/gcc-2.95.3-r5"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz

	epatch ${FILESDIR}/${P}_gentoo.patch.gz

	mkdir doc
	cd doc
	unpack ${PN}-tutorial-000328.html.tar.gz
	unpack ${PN}-specification-000328.html.tar.gz
	cp ${DISTDIR}/${PN}-tutorial-000328.ps.gz .
	cp ${DISTDIR}/${PN}-specification-000328.ps.gz .
	cp ${DISTDIR}/satish-thatte.ps.gz .
	cp ${DISTDIR}/Descript.ps.gz .
}

src_compile() {
	export SATHER_HOME="$S"
	export LOCALE="en_NZ"
	export SATHER_ENV="$SATHER_HOME/resources/$LOCALE/bin/LIBCHARS-posix"
	export SATHER_RESOURCES="$SATHER_HOME/resources/$LOCALE"
	export PATH="$PATH:$SATHER_HOME/bin"

	./configure linux || die
	make || die
}

src_install() {
	dodir /usr
	cp -pPR ${WORKDIR}/${MY_P} ${D}/usr/sather
	rm -rf ${D}/usr/${PN}/bin/sacomp.code
	rm -rf ${D}/usr/${PN}/bin/sacomp-boot.code
	rm -rf ${D}/usr/${PN}/sacomp
	rm -rf ${D}/usr/${PN}/sacomp-boot
	rm -rf ${D}/usr/${PN}/system
	dodir /usr/${PN}/system
	cp ${WORKDIR}/${PN}-1.3/system/CONFIG ${D}/usr/${PN}/system
	cp ${WORKDIR}/${PN}-1.3/system/FORBID ${D}/usr/${PN}/system

	cd ${WORKDIR}
	dodoc doc/${PN}-specification-000328.ps.gz doc/${PN}-tutorial-000328.ps.gz doc/satish-thatte.ps.gz doc/Descript.ps.gz
	cp -pPR doc/specification.html ${D}/usr/share/doc/${P}
	cp -pPR doc/tutorial.html ${D}/usr/share/doc/${P}

	dodir /etc/env.d
cat >> ${D}/etc/env.d/05sather <<EOF
SATHER_HOME="/usr/sather"
SATHER_ENV="/usr/sather/resources/en_NZ/bin/LIBCHARS-posix"
SATHER_RESOURCES="/usr/sather/resources/en_NZ"
PATH="/usr/sather/bin"
EOF
}
