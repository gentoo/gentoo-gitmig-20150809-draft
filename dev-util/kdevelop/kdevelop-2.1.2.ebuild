# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-2.1.2.ebuild,v 1.9 2002/08/16 04:04:42 murphy Exp $

inherit kde-base
need-kde 3

S=${WORKDIR}/${P}_for_KDE_3.0
DESCRIPTION="KDevelop ${PV}"
HOMEPAGE="www.kdevelop.org"
SRC_PATH="kde/stable/3.0.2/src/${P}_for_KDE_3.0.tar.bz2"
SRC_URI="ftp://ftp.kde.org/pub/$SRC_PATH
	ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
	ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH
	mirror://gentoo/c_cpp_reference-1.0.tar.gz
	mirror://gentoo/kdelibs-kdevelop-docs-3.0.1.tar.bz2"


LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"


DEPEND="$DEPEND
	sys-devel/flex
	sys-devel/perl"

newdepend ">=kde-base/kdebase-3
	>=dev-util/kdoc-2.0_alpha24
	>=dev-util/kdbg-1.2.5.3
	>=net-www/htdig-3.1.6
	>=app-text/enscript-1.6.1
	>=app-text/a2ps-4.13b
	>=dev-util/ctags-5.0.1
	>=app-text/sgmltools-lite-3.0.3
	>=app-doc/qt-docs-${QTVER}"

src_unpack() {
    base_src_unpack
    cd ${S}/kdevelop
    for x in *.desktop; do
	mv $x $x.2
	sed -e 's:Exec=kdevelop:Exec=env WANT_AUTOMAKE_1_4=1 WANT_AUTOCONF_2_5=1 kdevelop:g' $x.2 > $x
	rm $x.2
    done

}

src_install() {

    kde_src_install
    
    # setup htdig for use with kdevelop out-of-the-box (sort of)
    sed -e "s:_KDEDIR_:${PREFIX}:g" ${FILESDIR}/htdig.conf > ${D}/${PREFIX}/share/apps/kdevelop/tools/htdig.conf
    dodir ${PREFIX}/share/apps/kdevelop/htdig/db
    
    # kdelibs documentation - pregenerated so we don't need kdelibs sources etc
    cp -r ${WORKDIR}/KDE-Documentation ${D}/${PREFIX}/share/apps/kdevelop/
    
    # c/cpp reference package
    dodir ${PREFIX}/share/doc/HTML/en/kdevelop/reference
    cp -r ${WORKDIR}/c_cpp_reference-1.0/reference/{C,CPLUSPLUS,GRAPHICS} ${D}/${PREFIX}/share/doc/HTML/en/kdevelop/reference/

}

pkg_postinst() {

einfo "Don't run the kdevelop setup! It will try to generate the kdelibs documentation,"
einfo "but a pregenerated package of it has been installed with this ebuild."
einfo "Instead, run kdevelop, go to Options->Kdevelop Setup, Documentation tab, and change"
einfo "the value of KDE-Libraries-Doc to $PREFIX/share/apps/kdevelop/KDE-Documentation/ ."
einfo ""
einfo "Oh, and if you think of a nice way to automate this from the ebuild, pray tell"
einfo "(but test first!) :-)"


}

