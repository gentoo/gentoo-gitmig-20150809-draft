# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.1.5.ebuild,v 1.7 2004/01/19 14:17:06 caleb Exp $

inherit kde eutils
need-kde 3.1

IUSE=""
MY_P=${P}_for_KDE_3.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="http://www.kdevelop.org/"
SRC_URI="mirror://kde/stable/${P}/src/${MY_P}.tar.bz2
	ftp://ftp.ee.fhm.edu/pub/unix/ide/KDevelop/c_cpp_reference-2.0.2_for_KDE_3.0.tar.bz2
	mirror://gentoo/$PN-2.1.3-qt-templates.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=kde-base/kdebase-3
	>=dev-util/kdoc-2.0_alpha24
	>=dev-util/kdbg-1.2.5.3
	>=net-www/htdig-3.1.6
	>=app-text/enscript-1.6.1
	>=app-text/a2ps-4.13b
	>=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3
	>=app-doc/qt-docs-${QTVER}
	app-doc/kdelibs-apidocs
	=sys-devel/flex-2.5.4*
	dev-lang/perl"

# -j2 and greater fails - see bug #6199
export MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	kde_src_unpack
	cd ${S}/kdevelop
	for x in *.desktop; do
		mv $x $x.2
		sed -e 's:Exec=kdevelop:Exec=env WANT_AUTOMAKE_1_4=1 WANT_AUTOCONF_2_5=1 kdevelop:g' $x.2 > $x
		rm $x.2
	done
	cd ${WORKDIR}
	mv q*.tar.gz ${S}/kdevelop/templates/
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	kde_src_compile
	cd ${WORKDIR}/c_cpp_reference-2.0.2_for_KDE_3.0
	econf --with-qt-dir=/usr/qt/3
	emake
}

src_install() {
	kde_src_install
	# setup htdig for use with kdevelop out-of-the-box (sort of)
	sed -e "s:_KDEDIR_:${PREFIX}:g" \
	${FILESDIR}/htdig.conf > ${D}/${PREFIX}/share/apps/kdevelop/tools/htdig.conf
	dodir ${PREFIX}/share/apps/kdevelop/htdig/db

	# c/cpp reference package
	cd ${WORKDIR}/c_cpp_reference-2.0.2_for_KDE_3.0
	einstall
}
