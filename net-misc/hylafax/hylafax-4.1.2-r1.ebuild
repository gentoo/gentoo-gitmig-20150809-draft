# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.1.2-r1.ebuild,v 1.4 2002/08/13 23:00:53 raker Exp $

S=${WORKDIR}/${P}
MYSED=sed-3.02
PATCHES=${WORKDIR}/patches
DESCRIPTION="Fax package for class 1 and 2 fax modems."
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"
HOMEPAGE="http://www.hylafax.org"
KEYWORDS="x86"
LICENSE="hylafax"
SLOT="0"

DEPEND="net-dialup/mgetty
	sys-libs/zlib
	app-text/ghostscript
	media-libs/tiff
	jpeg? ( media-libs/jpeg )"

src_unpack() {
	
	unpack ${P}.tar.gz
	mkdir patches
	cd patches
	tar jxvf ${FILESDIR}/${P}-gentoo-diffs.tar.bz2
	cd ${S}
	patch -p1 < ${PATCHES}/${P}-dso.chris.patch
	patch -p1 < ${PATCHES}/${P}-shlib-pic.chris.patch
	patch -p1 < ${PATCHES}/${P}-gentoo.patch
	patch -p1 < ${PATCHES}/${P}-topmargin.patch
	patch < ${PATCHES}/${P}-configure.patch

}

src_compile() {
	
	./configure	\
		--with-DIR_BIN=/usr/bin \
		--with-DIR_SBIN=/usr/sbin \
		--with-DIR_LIB=/usr/lib \
		--with-DIR_LIBEXEC=/usr/sbin \
		--with-DIR_LIBDATA=/usr/lib/fax \
		--with-DIR_LOCKS=/var/lock \
		--with-DIR_MAN=/usr/share/man \
		--with-DIR_SPOOL=/var/spool/fax \
		--with-AFM=no \
		--with-AWK=/usr/bin/gawk \
		--with-PATH_VGETTY=/sbin/vgetty \
		--with-PATH_GETTY=/sbin/agetty \
		--with-HTML=no \
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax \
		--with-PATH_IMPRIP=/usr/share/fax/psrip \
		--with-SYSVINIT=/etc/init.d \
		--with-INTERACTIVE=no || die
	
	make \
		OPTIMIZER="${CFLAGS}" || die
}

src_install() {

	dodir /usr/{bin,sbin} /usr/lib/fax /usr/share/man /var/spool/fax

	make \
		BIN=${D}/usr/bin \
		SBIN=${D}/usr/sbin \
		LIBDIR=${D}/usr/lib \
		LIB=${D}/usr/lib \
		LIBEXEC=${D}/usr/sbin \
		LIBDATA=${D}/usr/lib/fax \
		MAN=${D}/usr/share/man \
		SPOOL=${D}/var/spool/fax \
		install || die
	
	insinto /etc/init.d
	insopts -m 755
	doins etc/hylafax

	dodoc COPYRIGHT README TODO VERSION
	dohtml -r .
}
