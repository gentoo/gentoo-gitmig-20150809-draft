# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-0.9.90.ebuild,v 1.10 2003/09/06 20:28:41 msterret Exp $

IUSE="kde"

S=${WORKDIR}/${P}
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/LinCVS/${P}/${P}-0-generic-src.tgz"
HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"

DEPEND="kde? ( =kde-base/kdelibs-2* )
	=x11-libs/qt-2*"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/nodefaults.diff
}

src_compile() {
	if [ "`use kde`" ] ; then
		myconf="${myconf} --with-kde2-support=yes"
	else
		myconf="${myconf} --with-kde2-support=no"
	fi

	libtoolize --copy --force

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--host=${CHOST} \
		--with-qt-dir=/usr/qt/2 \
		${myconf} || die "configure failed"

	cd ${S}/src
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
	cd ${S}

	make || die "make failed"
}

src_install () {
	into /usr
	dobin src/lincvs tools/*.sh
	insinto /usr/share/doc/${P}
	insopts -m 644
	doins AUTHORS COPYING ChangeLog INSTALL \
		README SSH.txt VERSION THANKS
	dosym /usr/share/doc/${P} /usr/share/${PN}
}
